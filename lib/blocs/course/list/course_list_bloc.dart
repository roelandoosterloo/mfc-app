import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/models/course.dart';
import 'package:mfc_app/repositories/course_repository.dart';

part 'course_list_event.dart';
part 'course_list_state.dart';

class CourseListBloc extends Bloc<CourseListEvent, CourseListState> {
  final CourseRepository _courseRepo;

  CourseListBloc({required CourseRepository courseRepo})
      : _courseRepo = courseRepo,
        super(CourseInitial());

  void refresh() {
    _courseRepo.refreshCourseList().listen((event) {
      add(CourseListFound(event));
    }, onError: (error) {
      print(error);
      add(CourseListLoadingFailed(error.toString()));
    });
  }

  @override
  Stream<CourseListState> mapEventToState(CourseListEvent event) async* {
    if (event is CourseListRequested) {
      yield* _mapListRequestToState();
    } else if (event is CourseListFound) {
      yield* _mapListToState(event.courses);
    } else if (event is CourseListLoadingFailed) {
      yield* _mapLoadingFailureToState(event.error);
    }
  }

  Stream<CourseListState> _mapListRequestToState() async* {
    yield CourseListLoading();
    refresh();
  }

  Stream<CourseListState> _mapListToState(List<Course> courses) async* {
    yield CourseListAvailable(courses: courses);
  }

  Stream<CourseListState> _mapLoadingFailureToState(String error) async* {
    yield CourseListFailed(error: error);
  }
}
