import 'package:courses_app/features/favorites/domain/repository/favorites_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../courses/domain/entity/course_entity.dart';

class GetFavoriteCoursesUseCase {
  final FavoritesRepository favoritesRepository;

  const GetFavoriteCoursesUseCase(this.favoritesRepository);
  Future<Either<Failure, List<CourseEntity>>> call() {
    return favoritesRepository.getFavoriteCourses();
  }
}
