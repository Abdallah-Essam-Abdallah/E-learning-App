import 'package:courses_app/core/error/failure.dart';
import 'package:courses_app/core/network/internet_connection.dart';
import 'package:courses_app/core/utils/appstrings.dart';
import 'package:courses_app/features/profile/data/data_source/profile_datasource.dart';
import 'package:courses_app/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/exception.dart';
import '../../../authentication/domain/entity/user.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource profileDataSource;
  final InternetConnection internetConnection;

  ProfileRepositoryImpl(this.profileDataSource, this.internetConnection);

  @override
  Future<Either<Failure, String>> uploadProfileImage() async {
    if (await internetConnection.isInternetConnected) {
      try {
        String imageUrl = await profileDataSource.uploadProfileImage();
        return right(imageUrl);
      } on NoImageChoosedException catch (e) {
        return left(NoImageChoosedFaliure(e.message));
      } on ImageUplodedException catch (e) {
        return left(ImageUplodedFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    if (await internetConnection.isInternetConnected) {
      try {
        final userData = await profileDataSource.getUserData();
        return right(userData);
      } on GetUserDataException catch (e) {
        return left(GetUserDataFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    if (await internetConnection.isInternetConnected) {
      try {
        await profileDataSource.signOut();
        return right(unit);
      } on SignOutException catch (e) {
        return left(SignOutFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }
}
