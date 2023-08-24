part of 'content_bloc.dart';

abstract class ContentState extends Equatable {
  const ContentState();

  @override
  List<Object> get props => [];
}

class ContentInitial extends ContentState {}

class PlayVideoLoadingState extends ContentState {}

class PlayVideoLoadedState extends ContentState {}

class PlayVideoErrorState extends ContentState {
  final String error;

  const PlayVideoErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class GetBookedCoursesLoadingState extends ContentState {}

class GetBookedCoursesLoadedState extends ContentState {
  final List<CourseEntity> courses;

  const GetBookedCoursesLoadedState({required this.courses});

  @override
  List<Object> get props => [courses];
}

class GetBookedCoursesErrorState extends ContentState {
  final String error;

  const GetBookedCoursesErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
