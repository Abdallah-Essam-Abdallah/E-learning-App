import 'package:courses_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class VerifyEmailUseCase {
  final AuthenticationRepository authenticationRepository;

  const VerifyEmailUseCase(this.authenticationRepository);

  Future<Either<Failure, Unit>> call() async {
    return await authenticationRepository.verifyEmail();
  }
}
