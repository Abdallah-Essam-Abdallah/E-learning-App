import 'package:courses_app/features/favorites/domain/repository/favorites_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../courses/domain/entity/course_entity.dart';

class AddCourseToFavoriresUseCase {
  final FavoritesRepository favoritesRepository;

  const AddCourseToFavoriresUseCase(this.favoritesRepository);

  Future<Either<Failure, Unit>> call(
      {required CourseEntity favoriteCourse}) async {
    return await favoritesRepository.addCourseToFavorites(
        favoriteCourse: favoriteCourse);
  }
}
