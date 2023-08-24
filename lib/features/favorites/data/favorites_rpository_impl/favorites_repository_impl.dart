import 'package:courses_app/core/error/exception.dart';
import 'package:courses_app/features/courses/data/model/course_model.dart';
import 'package:courses_app/core/error/failure.dart';
import 'package:courses_app/features/favorites/data/data_source/favorites_data_source.dart';
import 'package:courses_app/features/favorites/domain/repository/favorites_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../courses/domain/entity/course_entity.dart';

class FavoritesRepositoryImpl extends FavoritesRepository {
  final FavoritesDataSource favoritesDataSource;

  FavoritesRepositoryImpl(this.favoritesDataSource);
  @override
  Future<Either<Failure, Unit>> addCourseToFavorites(
      {required CourseEntity favoriteCourse}) async {
    try {
      await favoritesDataSource.addCourseToFavorites(
          favoriteCourse: favoriteCourse);
      return right(unit);
    } on AddCourseToFavoriteException catch (e) {
      return left(AddCourseToFavoriteFaliure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CourseModel>>> getFavoriteCourses() async {
    try {
      final result = await favoritesDataSource.getFavoriteCourses();
      return right(result);
    } on GetFavoriteCoursesException catch (e) {
      return left(GetFavoriteCoursesFaliure(e.message));
    }
  }
}
