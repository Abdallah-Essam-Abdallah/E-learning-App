import 'package:courses_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

import '../../../authentication/domain/entity/user.dart';

abstract class ProfileRepository {
  Future<Either<Failure, String>> uploadProfileImage();
  Future<Either<Failure, UserEntity>> getUserData();
  Future<Either<Failure, Unit>> signOut();
}
