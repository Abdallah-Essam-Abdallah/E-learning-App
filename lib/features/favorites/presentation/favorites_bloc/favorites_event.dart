part of 'favorites_bloc.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object> get props => [];
}

class AddCourseToFavoriresEvent extends FavoritesEvent {
  final bool isFavorite;
  final CourseEntity course;

  const AddCourseToFavoriresEvent(
      {required this.course, required this.isFavorite});
  @override
  List<Object> get props => [course, isFavorite];
}

class RemoveCourseFromFavoriresEvent extends FavoritesEvent {
  final bool isFavorite;
  final int index;
  final CourseModel course;

  const RemoveCourseFromFavoriresEvent(
      {required this.course, required this.index, required this.isFavorite});
  @override
  List<Object> get props => [course, index, isFavorite];
}

class GetFavoriteCoursesEvent extends FavoritesEvent {
  const GetFavoriteCoursesEvent();
  @override
  List<Object> get props => [];
}
