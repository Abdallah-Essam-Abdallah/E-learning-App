import 'package:courses_app/features/courses/domain/repository/courses_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/course_entity.dart';

class GetCoursesByCategoryUseCase {
  final CoursesRepository coursesRepository;

  const GetCoursesByCategoryUseCase(this.coursesRepository);
  Future<Either<Failure, List<CourseEntity>>> call(
      {required String category}) async {
    return await coursesRepository.getCoursesByCategory(category: category);
  }
}
