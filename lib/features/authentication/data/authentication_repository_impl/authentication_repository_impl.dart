import 'package:courses_app/core/error/exception.dart';
import 'package:courses_app/core/error/failure.dart';
import 'package:courses_app/core/utils/appstrings.dart';

import 'package:courses_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/network/internet_connection.dart';
import '../data_source/authentication_datasource.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDataSource authenticationDataSource;
  final InternetConnection internetConnection;

  AuthenticationRepositoryImpl(
      this.authenticationDataSource, this.internetConnection);

  @override
  Future<Either<Failure, Unit>> signUp({
    required String userName,
    required String password,
    required String email,
    required String phoneNumber,
  }) async {
    if (await internetConnection.isInternetConnected) {
      try {
        await authenticationDataSource.signUp(email, password);

        await createUserInDatabase(
          userName: userName,
          email: email,
          phoneNumber: phoneNumber,
          favorites: [],
        );
        await verifyEmail();
        return right(unit);
      } on AuthenticationException catch (e) {
        if (e is EmailAlreadyInUseException) {
          return Left((EmailAlreadyInUseFaliure(e.message)));
        } else if (e is InvalidEmailException) {
          return Left(InvalidEmailFaliure(e.message));
        } else if (e is WeakPasswordException) {
          return Left(WeakPasswordFaliure(e.message));
        } else {
          return Left(UnexpectedFaliure(e.toString()));
        }
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> signInWithEmailAndPassword(
      String email, String password) async {
    if (await internetConnection.isInternetConnected) {
      try {
        await authenticationDataSource.signInWithEmailAndPassword(
            email, password);

        return right(unit);
      } on AuthenticationException catch (e) {
        if (e is InvalidEmailException) {
          return Left(InvalidEmailFaliure(e.message));
        } else if (e is WrongPasswordException) {
          return Left(WrongPasswordFaliure(e.message));
        } else if (e is UserNotFoundException) {
          return Left(UserNotFoundFaliure(e.message));
        } else if (e is TooManyRequestsException) {
          return Left(TooManyRequestsFaliure(e.message));
        } else {
          return Left(UnexpectedFaliure(e.toString()));
        }
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> createUserInDatabase({
    required String userName,
    required String email,
    required String phoneNumber,
    required List favorites,
  }) async {
    if (await internetConnection.isInternetConnected) {
      try {
        await authenticationDataSource.createUserInDatabase(
          userName: userName,
          email: email,
          phoneNumber: phoneNumber,
          userId: FirebaseAuth.instance.currentUser!.uid,
        );
        return right(unit);
      } on CreateUserInDatabaseException catch (e) {
        return left(CreateUserInDatabaseFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> verifyEmail() async {
    if (await internetConnection.isInternetConnected) {
      try {
        await authenticationDataSource.verifyEmail();
        return right(unit);
      } catch (e) {
        return left(UnexpectedFaliure(e.toString()));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword({required String email}) async {
    if (await internetConnection.isInternetConnected) {
      try {
        await authenticationDataSource.resetPassword(email: email);
        return right(unit);
      } catch (e) {
        return left(ResetPasswordFaliure(e.toString()));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> signInWithFacebook() {
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User?>> signInWithGoogle() async {
    late final User user;
    if (await internetConnection.isInternetConnected) {
      try {
        await authenticationDataSource.signInWithGoogle();
        user = FirebaseAuth.instance.currentUser!;
      } on AuthenticationException catch (e) {
        if (e is AccountExistsWithDifferentCredentialException) {
          return left(AccountExistsWithDifferentCredentialFaliure(e.message));
        } else if (e is InvalidCredentialException) {
          return left(InvalidCredentialFaliure(e.message));
        } else if (e is SignInWithGoogleException) {
          return left(SignInWithGoogleFaliure(e.message));
        }
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
    return right(user);
  }
}
