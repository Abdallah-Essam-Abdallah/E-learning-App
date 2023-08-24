import 'package:courses_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class SignInWithFacebookUseCase {
  final AuthenticationRepository authenticationRepository;

  const SignInWithFacebookUseCase(this.authenticationRepository);

  Future<Either<Failure, Unit>> call() async {
    return await authenticationRepository.signInWithFacebook();
  }
}
