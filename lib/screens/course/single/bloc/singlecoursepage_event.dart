part of 'singlecoursepage_bloc.dart';

abstract class SingleCoursePageEvent extends Equatable {
  const SingleCoursePageEvent();

  @override
  List<Object> get props => [];
}

class SingleCoursePageOpened extends SingleCoursePageEvent {}

class SingleCoursePageModuleSelected extends SingleCoursePageEvent {
  final ModuleProgress _module;

  SingleCoursePageModuleSelected(this._module);

  ModuleProgress get module {
    return _module;
  }

  @override
  List<Object> get props => [_module];
}
