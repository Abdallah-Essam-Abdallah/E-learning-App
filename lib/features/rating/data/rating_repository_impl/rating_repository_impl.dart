import 'package:courses_app/core/error/exception.dart';
import 'package:courses_app/core/error/failure.dart';
import 'package:courses_app/features/rating/data/data_source/rating_data_source.dart';
import 'package:courses_app/features/rating/domain/entity/rating_entity.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/network/internet_connection.dart';
import '../../../../core/utils/appstrings.dart';
import '../../domain/repository/rating_repository.dart';

class RatingRepositoryImpl extends RatingRepository {
  final RatingDataSource ratingDataSource;
  final InternetConnection internetConnection;

  RatingRepositoryImpl(this.ratingDataSource, this.internetConnection);

  @override
  Future<Either<Failure, Unit>> addRating(
      {required String comment,
      required double stars,
      required String course,
      required String userName,
      required String userImage}) async {
    if (await internetConnection.isInternetConnected) {
      try {
        await ratingDataSource.addRating(
            comment: comment,
            stars: stars,
            course: course,
            userName: userName,
            userImage: userImage);
        return right(unit);
      } on AddRatingException catch (e) {
        return left(AddRatingFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, List<RatingEntity>>> getRating(
      {required String course}) async {
    if (await internetConnection.isInternetConnected) {
      try {
        final result = await ratingDataSource.getRating(course: course);
        return right(result);
      } on GetRatingException catch (e) {
        return left(GetRatingFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }
}
