part of 'homepage_bloc.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class HomePageOpened extends HomePageEvent {}

class HomePageReopend extends HomePageEvent {}

class CourseSelected extends HomePageEvent {
  final String courseId;

  CourseSelected(this.courseId);

  @override
  List<Object> get props => [this.courseId];
}
