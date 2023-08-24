import 'package:courses_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class ResetPasswordUseCase {
  final AuthenticationRepository authenticationRepository;

  const ResetPasswordUseCase(this.authenticationRepository);

  Future<Either<Failure, Unit>> call({required String email}) async {
    return await authenticationRepository.resetPassword(email: email);
  }
}
