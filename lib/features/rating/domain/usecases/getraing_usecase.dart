import 'package:courses_app/features/rating/domain/repository/rating_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/rating_entity.dart';

class GetRatingUseCase {
  final RatingRepository ratingRepository;

  const GetRatingUseCase(this.ratingRepository);

  Future<Either<Failure, List<RatingEntity>>> call(
      {required String course}) async {
    return await ratingRepository.getRating(course: course);
  }
}
