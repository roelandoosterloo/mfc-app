import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mfc_app/models/Membership.dart';
import 'package:mfc_app/models/Program.dart';
import 'package:mfc_app/repositories/program_repository.dart';
import 'package:mfc_app/repositories/store_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

part 'list_program_event.dart';
part 'list_program_state.dart';

class ListProgramBloc extends Bloc<ListProgramEvent, ListProgramState> {
  final ProgramRepository _programRepo;
  final StoreRepository _storeRepo;
  final UserRepository _userRepo;
  StreamSubscription? _purchaseListener;

  ListProgramBloc({
    required ProgramRepository programRepo,
    required StoreRepository storeRepo,
    required UserRepository userRepo,
  })  : _programRepo = programRepo,
        _storeRepo = storeRepo,
        _userRepo = userRepo,
        super(ListProgramInitial()) {
    on<ListProgramOpened>(_onListProgramOpened);
    on<PurchaseProgram>(_onProgramPurchased);
    on<PurchaseFailed>(_onPurchaseFailed);
    on<PurchaseCompleted>(_onPurchaseCompleted);
    on<PurchasesRestoreRequested>(_onRestorePurchases);

    _storeRepo.purchaseStream().then(
      (stream) {
        _purchaseListener = stream.listen((List<PurchaseDetails> detailList) {
          detailList.forEach((PurchaseDetails details) async {
            if (details.status != PurchaseStatus.pending) {
              if (details.status == PurchaseStatus.error) {
                add(
                  PurchaseFailed(details.error!.message),
                );
              } else if (details.status == PurchaseStatus.purchased ||
                  details.status == PurchaseStatus.restored) {
                try {
                  bool success = await _programRepo.createMembership(
                    details.productID,
                    details.purchaseID!,
                  );
                  if (success == false) {
                    add(PurchaseFailed("Aanmelding mislukt"));
                  }
                  if (success == true) {
                    add(PurchaseCompleted());
                  }
                } catch (ex) {
                  await Sentry.captureException(ex);
                  add(PurchaseFailed(
                      "Aanmelden mislukt probeer later opnieuw"));
                }
              }
              if (details.pendingCompletePurchase) {
                await _storeRepo.completePurchase(details);
              }
            }
          });
        });
      },
    );
  }

  @override
  Future<void> close() {
    if (_purchaseListener != null) {
      _purchaseListener!.cancel();
    }
    return super.close();
  }

  void _onListProgramOpened(
    ListProgramOpened event,
    Emitter<ListProgramState> emit,
  ) async {
    emit(Loading());
    try {
      List<Membership> memberships = await _programRepo.listMemberships();
      Stream<List<Program>> programStream = _programRepo.listProgramsForSale();
      await programStream.forEach((programs) {
        if (programs.isEmpty) {
          emit(NoProgramAvailable());
        } else {
          emit(Loaded(programs, memberships));
        }
      });
    } on Exception catch (ex) {
      await Sentry.captureException(ex);
      emit(FailedLoading(ex.toString()));
    }
  }

  Future<void> _onProgramPurchased(
    PurchaseProgram event,
    Emitter<ListProgramState> emit,
  ) async {
    emit(PaymentPending(
      programId: event.program.id,
      programs: (state as Loaded).programs,
      memberships: (state as Loaded).memberships,
    ));
    if (event.program.productStoreId == null) {
      return;
    }
    try {
      String username = await _userRepo.getUsername();
      ProductDetails detail =
          await _storeRepo.getProduct(event.program.productStoreId!);
      await _storeRepo.makePurchase(detail, username);
    } on StoreException catch (ex) {
      await Sentry.captureException(ex);
      emit(PaymentFailed(
        message: ex.error,
        programs: (state as Loaded).programs,
        memberships: (state as Loaded).memberships,
      ));
    }
  }

  Future<void> _onPurchaseFailed(
    PurchaseFailed event,
    Emitter<ListProgramState> emit,
  ) async {
    emit(PaymentFailed(
      message: event._error,
      programs: (state as Loaded).programs,
      memberships: (state as Loaded).memberships,
    ));
  }

  Future<void> _onPurchaseCompleted(
    PurchaseCompleted event,
    Emitter<ListProgramState> emit,
  ) async {
    try {
      List<Membership> memberships = await _programRepo.listMemberships();
      emit(PaymentSucceeded(
        (state as Loaded).programs,
        memberships,
      ));
    } on Exception catch (e) {
      await Sentry.captureException(e);
      emit(FailedLoading(e.toString()));
    }
  }

  Future<void> _onRestorePurchases(
    PurchasesRestoreRequested event,
    Emitter<ListProgramState> emit,
  ) async {
    try {
      String username = await _userRepo.getUsername();
      return _storeRepo.restorePurchases(username);
    } catch (ex) {
      await Sentry.captureException(ex);
      this.add(PurchaseFailed("Kon aankopen niet herstellen"));
    }
  }
}
