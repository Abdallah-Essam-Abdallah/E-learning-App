import 'package:courses_app/features/rating/domain/repository/rating_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class AddRatingUseCase {
  final RatingRepository ratingRepository;

  const AddRatingUseCase(this.ratingRepository);

  Future<Either<Failure, Unit>> call(
      {required String comment,
      required double stars,
      required String course,
      required String userName,
      required String userImage}) async {
    return await ratingRepository.addRating(
        comment: comment,
        stars: stars,
        course: course,
        userName: userName,
        userImage: userImage);
  }
}
