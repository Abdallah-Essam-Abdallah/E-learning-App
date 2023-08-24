import 'package:courses_app/features/courses/domain/repository/courses_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/course_entity.dart';

class GetCoursesBySearchUseCase {
  final CoursesRepository coursesRepository;

  const GetCoursesBySearchUseCase(this.coursesRepository);
  Future<Either<Failure, List<CourseEntity>>> call(
      {required String searchValue}) async {
    return await coursesRepository.getCoursesBySearch(searchValue: searchValue);
  }
}
