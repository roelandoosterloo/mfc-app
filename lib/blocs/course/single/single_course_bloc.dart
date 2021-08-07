import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mfc_app/models/course.dart';
import 'package:mfc_app/repositories/course_repository.dart';

part 'single_course_event.dart';
part 'single_course_state.dart';

class SingleCourseBloc extends Bloc<SingleCourseEvent, SingleCourseState> {
  final CourseRepository _courseRepo;

  SingleCourseBloc({required CourseRepository courseRepo})
      : _courseRepo = courseRepo,
        super(SingleInitial());

  @override
  Stream<SingleCourseState> mapEventToState(SingleCourseEvent event) async* {
    if (event is CourseSelected) {
      yield* _mapCourseSelectedToState(event.courseId);
    }
  }

  Stream<SingleCourseState> _mapCourseSelectedToState(String courseId) async* {
    yield CourseLoading();
    try {
      Course? course = await _courseRepo.getCourse(courseId);
      if (course != null) {
        yield CourseAvailable(course: course);
      } else {
        yield CourseNotFound();
      }
    } catch (ex) {
      yield CourseLoadingFailed(error: ex.toString());
    }
  }
}
