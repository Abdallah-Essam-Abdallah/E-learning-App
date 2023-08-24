import 'package:courses_app/core/error/failure.dart';

import 'package:courses_app/features/courses/domain/entity/course_entity.dart';
import 'package:dartz/dartz.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, Unit>> addCourseToFavorites(
      {required CourseEntity favoriteCourse});

  Future<Either<Failure, List<CourseEntity>>> getFavoriteCourses();
}
