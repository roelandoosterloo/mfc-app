import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:mfc_app/models/course/Membership.dart';
import 'package:mfc_app/models/course/Program.dart';
import 'package:mfc_app/repositories/program_repository.dart';
import 'package:mfc_app/repositories/store_repository.dart';

part 'list_program_event.dart';
part 'list_program_state.dart';

class ListProgramBloc extends Bloc<ListProgramEvent, ListProgramState> {
  final ProgramRepository _programRepo;
  final StoreRepository _storeRepo;

  ListProgramBloc({
    required ProgramRepository programRepo,
    required StoreRepository storeRepo,
  })  : _programRepo = programRepo,
        _storeRepo = storeRepo,
        super(ListProgramInitial()) {
    on<ListProgramOpened>(_onListProgramOpened);
    on<PurchaseProgram>(_onProgramPurchased);
    on<PurchaseFailed>(_onPurchaseFailed);

    _storeRepo.purchaseStream().then(
          (stream) => stream.listen((List<PurchaseDetails> detailList) {
            detailList.forEach((PurchaseDetails details) async {
              if (details.status != PurchaseStatus.pending) {
                if (details.status == PurchaseStatus.error) {
                  print(details.error);
                  add(
                    PurchaseFailed(details.error!.message),
                  );
                } else if (details.status == PurchaseStatus.purchased ||
                    details.status == PurchaseStatus.restored) {
                  await _programRepo.createMembership(
                    details.productID,
                    details.purchaseID!,
                  );
                }
                if (details.pendingCompletePurchase) {
                  await _storeRepo.completePurchase(details);
                }
              }
            });
          }),
        );
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
    } on Exception catch (e) {
      log(e.toString());
      emit(FailedLoading(e.toString()));
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
      ProductDetails detail =
          await _storeRepo.getProduct(event.program.productStoreId!);
      await _storeRepo.makePurchase(detail);
    } on StoreException catch (ex) {
      print(ex.error);
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
}
