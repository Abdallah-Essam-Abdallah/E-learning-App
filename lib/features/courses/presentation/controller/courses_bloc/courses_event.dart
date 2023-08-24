part of 'courses_bloc.dart';

abstract class CoursesEvent extends Equatable {
  const CoursesEvent();

  @override
  List<Object> get props => [];
}

class GetCoursesByCategoryEvent extends CoursesEvent {
  final String category;

  const GetCoursesByCategoryEvent(this.category);

  @override
  List<Object> get props => [category];
}

class GetCoursesBySearchEvent extends CoursesEvent {
  final String searchValue;

  const GetCoursesBySearchEvent(this.searchValue);

  @override
  List<Object> get props => [searchValue];
}

class GetTopRatedCoursesEvent extends CoursesEvent {}
