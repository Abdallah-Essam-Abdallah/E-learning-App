import 'package:courses_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class SignUpUseCase {
  final AuthenticationRepository authenticationRepository;

  const SignUpUseCase(this.authenticationRepository);

  Future<Either<Failure, Unit>> call({
    required String userName,
    required String password,
    required String email,
    required String phoneNumber,
  }) async {
    return await authenticationRepository.signUp(
      userName: userName,
      password: password,
      email: email,
      phoneNumber: phoneNumber,
    );
  }
}
