import 'package:courses_app/features/authentication/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class CreateUserInDatabaseUseCase {
  final AuthenticationRepository authenticationRepository;

  const CreateUserInDatabaseUseCase(this.authenticationRepository);

  Future<Either<Failure, Unit>> call(
    String userName,
    String email,
    String phoneNumber,
    List favorites,
  ) async {
    return await authenticationRepository.createUserInDatabase(
      userName: userName,
      email: email,
      phoneNumber: phoneNumber,
      favorites: favorites,
    );
  }
}
