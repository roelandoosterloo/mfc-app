import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/blocs/navigation/navigation_bloc.dart';
import 'package:mfc_app/models/Profile.dart';
import 'package:mfc_app/models/course/Course.dart';
import 'package:mfc_app/models/course/Enrollment.dart';
import 'package:mfc_app/repositories/course_repository.dart';
import 'package:mfc_app/repositories/profile_repository.dart';
import 'package:mfc_app/repositories/user_repository.dart';

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
    emit(HomePageLoading());
    try {
      List<Enrollment> enrollments = await _courseRepo.listEnrolledCourses();
      List<Course> courses = await _courseRepo.listCourses();
      AuthUser user = await _userRepo.getUser();
      Profile profile = await _profileRepo.getProfile(user.username);
      emit(
        HomePageLoaded(courses, enrollments, profile),
      );
    } catch (ex) {
      emit(HomePageError(ex.toString()));
    }
  }

  void _onCourseSelected(
    CourseSelected event,
    Emitter<HomePageState> emit,
  ) async {
    if (state is HomePageLoaded) {
      HomePageLoaded hplState = (state as HomePageLoaded);
      Enrollment? enrollment = hplState.enrollments.firstWhere(
          (enrollment) => enrollment.course.id == event.courseId,
          orElse: null);
      if (enrollment != null) {
        if (enrollment.startedAt == null) {
          _courseRepo.setCourseStartedAt(enrollment.id);
        }
        _navBloc.add(NavigatedToCourse(enrollment.id));
      }
    }
  }
}