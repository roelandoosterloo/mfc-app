import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/models/Profile.dart';
import 'package:mfc_app/models/Course.dart';
import 'package:mfc_app/models/Enrollment.dart';
import 'package:mfc_app/repositories/course_repository.dart';
import 'package:mfc_app/repositories/profile_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';
import 'package:mfc_app/utils/helpers.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:collection/collection.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final CourseRepository _courseRepo;
  final ProfileRepository _profileRepo;
  final UserRepository _userRepo;
  final NavigationBloc _navBloc;

  HomePageBloc({
    required CourseRepository courseRepo,
    required ProfileRepository profileRepo,
    required UserRepository userRepo,
    required NavigationBloc navBloc,
  })  : _courseRepo = courseRepo,
        _profileRepo = profileRepo,
        _userRepo = userRepo,
        _navBloc = navBloc,
        super(HomePageInitial()) {
    on<HomePageOpened>(_onHomePageOpened);
    on<CourseSelected>(_onCourseSelected);
  }

  void _onHomePageOpened(
    HomePageOpened event,
    Emitter<HomePageState> emit,
  ) async {
    try {
      List<Enrollment?> enrollments = await _courseRepo.listEnrolledCourses();
      List<Course> courses = await _courseRepo.listSubscribedCourses();
      String username = await _userRepo.getUsername();
      Profile profile = await _profileRepo.getProfile(username);
      emit(
        HomePageLoaded(courses, enrollments, profile),
      );
    } catch (ex, stack) {
      await Sentry.captureException(ex, stackTrace: stack);
      emit(HomePageError(ex.toString()));
    }
  }

  void _onCourseSelected(
    CourseSelected event,
    Emitter<HomePageState> emit,
  ) async {
    if (state is HomePageLoaded) {
      HomePageLoaded hplState = (state as HomePageLoaded);
      if (hplState.loadingCourse != null) {
        return;
      }
      emit((state as HomePageLoaded).setCourseLoading(event.courseId));

      Enrollment? enrollment;
      try {
        enrollment = hplState.enrollments.firstWhere(
          (enrollment) => enrollment.course?.id == event.courseId,
          orElse: null,
        );
      } catch (ex) {
        await Sentry.captureException(ex);
      }

      if (enrollment == null) {
        String username = await _userRepo.getUsername();
        enrollment =
            await _courseRepo.createEnrollment(username, event.courseId);
        this.add(HomePageOpened());
      }

      if (enrollment.startedAt == null) {
        try {
          await _courseRepo.setCourseStartedAt(enrollment);
        } catch (ex) {
          await Sentry.captureException(ex);
        }
      }
      if (!hplState.isCourseDone(event.courseId) &&
          hplState.profile.currentCourseId != event.courseId) {
        try {
          await _profileRepo.setCurrentCourse(
            hplState.profile,
            event.courseId,
          );
        } catch (ex) {
          await Sentry.captureException(ex);
        }
      }
      emit((state as HomePageLoaded).setCourseLoading(null));
      _navBloc.add(NavigatedToCourse(enrollment.id));
    }
  }
}
