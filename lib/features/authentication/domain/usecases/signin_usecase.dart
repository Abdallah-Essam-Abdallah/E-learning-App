import 'package:courses_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class SignInWithEmailAndPasswordUseCase {
  final AuthenticationRepository authenticationRepository;

  const SignInWithEmailAndPasswordUseCase(this.authenticationRepository);

  Future<Either<Failure, Unit>> call(String email, String password) async {
    return await authenticationRepository.signInWithEmailAndPassword(
        email, password);
  }
}
