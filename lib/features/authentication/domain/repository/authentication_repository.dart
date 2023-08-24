import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Unit>> signUp({
    required String userName,
    required String password,
    required String email,
    required String phoneNumber,
  });
  Future<Either<Failure, Unit>> verifyEmail();
  Future<Either<Failure, Unit>> resetPassword({
    required String email,
  });
  Future<Either<Failure, Unit>> createUserInDatabase({
    required String userName,
    required String email,
    required String phoneNumber,
    required List favorites,
  });

  Future<Either<Failure, Unit>> signInWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, User?>> signInWithGoogle();
  Future<Either<Failure, Unit>> signInWithFacebook();
}
