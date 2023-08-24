import 'package:courses_app/features/authentication/domain/entity/user.dart';

import 'package:courses_app/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class GetUserDataUseCase {
  final ProfileRepository profileRepository;

  const GetUserDataUseCase(this.profileRepository);

  Future<Either<Failure, UserEntity>> call() async {
    return await profileRepository.getUserData();
  }
}
