part of 'favorites_bloc.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object> get props => [];
}

class FavoritesInitial extends FavoritesState {}

class AddCourseToFavoriresState extends FavoritesState {}

class RemoveCoursefromFavoriresState extends FavoritesState {}

class GetFavoriteCoursesLoadingState extends FavoritesState {}

class GetFavoriteCoursesLoadedState extends FavoritesState {
  final List<CourseEntity> courses;
  const GetFavoriteCoursesLoadedState({required this.courses});
  @override
  List<Object> get props => [courses];
}

class GetFavoriteCoursesErrorState extends FavoritesState {
  final String error;

  const GetFavoriteCoursesErrorState({required this.error});
  @override
  List<Object> get props => [error];
}
