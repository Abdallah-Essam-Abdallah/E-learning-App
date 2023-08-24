import 'package:courses_app/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class SignOutUseCase {
  final ProfileRepository profileRepository;

  const SignOutUseCase(this.profileRepository);

  Future<Either<Failure, Unit>> call() async {
    return await profileRepository.signOut();
  }
}
