import 'package:courses_app/features/content/domain/repository/content_repository.dart';
import 'package:courses_app/features/courses/domain/entity/course_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class GetBookedCoursesUseCase {
  final ContentRepository contentRepository;

  const GetBookedCoursesUseCase(this.contentRepository);
  Future<Either<Failure, List<CourseEntity>>> call() async {
    return await contentRepository.getBookedCourses();
  }
}
