import 'package:courses_app/core/error/failure.dart';
import 'package:courses_app/features/rating/domain/entity/rating_entity.dart';
import 'package:dartz/dartz.dart';

abstract class RatingRepository {
  Future<Either<Failure, Unit>> addRating(
      {required String comment,
      required double stars,
      required String course,
      required String userName,
      required String userImage});

  Future<Either<Failure, List<RatingEntity>>> getRating(
      {required String course});
}
