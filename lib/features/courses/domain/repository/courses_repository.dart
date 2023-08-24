import 'package:courses_app/core/error/failure.dart';

import 'package:dartz/dartz.dart';

import '../entity/course_entity.dart';

abstract class CoursesRepository {
  Future<Either<Failure, List<CourseEntity>>> getTopRatedCourses();
  Future<Either<Failure, List<CourseEntity>>> getCoursesByCategory(
      {required String category});

  Future<Either<Failure, List<CourseEntity>>> getCoursesBySearch(
      {required String searchValue});
}
