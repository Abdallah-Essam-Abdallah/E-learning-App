import 'package:courses_app/core/error/failure.dart';

import 'package:courses_app/features/courses/domain/entity/course_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ContentRepository {
  Future<Either<Failure, List<CourseEntity>>> getBookedCourses();

  Future<void> playVideo({required String url});
}
