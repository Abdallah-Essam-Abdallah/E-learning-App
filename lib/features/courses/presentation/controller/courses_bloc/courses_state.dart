part of 'courses_bloc.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object> get props => [];
}

class CoursesInitial extends CoursesState {}

class GetCoursesByCategoryLoadingState extends CoursesState {}

class GetCoursesByCategoryLoadedState extends CoursesState {
  final List<CourseEntity> coursesByCategory;

  const GetCoursesByCategoryLoadedState({required this.coursesByCategory});
  @override
  List<Object> get props => [coursesByCategory];
}

class GetCoursesByCategoryErrorState extends CoursesState {
  final String error;

  const GetCoursesByCategoryErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class GetTopRatedCoursesLoadingState extends CoursesState {}

class GetTopRatedCoursesLoadedState extends CoursesState {
  final List<CourseEntity> topRatedCourses;

  const GetTopRatedCoursesLoadedState({required this.topRatedCourses});
  @override
  List<Object> get props => [topRatedCourses];
}

class GetTopRatedCoursesErrorState extends CoursesState {
  final String error;

  const GetTopRatedCoursesErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class GetCoursesBySearchLoadingState extends CoursesState {}

class GetCoursesBySearchLoadedState extends CoursesState {
  final List<CourseEntity> coursesBySearch;

  const GetCoursesBySearchLoadedState({required this.coursesBySearch});
  @override
  List<Object> get props => [coursesBySearch];
}

class GetCoursesBySearchErrorState extends CoursesState {
  final String error;

  const GetCoursesBySearchErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
