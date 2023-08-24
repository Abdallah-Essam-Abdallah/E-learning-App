import 'package:courses_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/error/failure.dart';

class SignInWithGoogleUseCase {
  final AuthenticationRepository authenticationRepository;

  const SignInWithGoogleUseCase(this.authenticationRepository);

  Future<Either<Failure, User?>> call() async {
    return await authenticationRepository.signInWithGoogle();
  }
}
