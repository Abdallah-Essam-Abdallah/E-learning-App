import 'package:courses_app/features/courses/domain/repository/courses_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/course_entity.dart';

class GetTopRatedCoursesUseCase {
  final CoursesRepository coursesRepository;

  const GetTopRatedCoursesUseCase(this.coursesRepository);
  Future<Either<Failure, List<CourseEntity>>> call() async {
    return await coursesRepository.getTopRatedCourses();
  }
}
