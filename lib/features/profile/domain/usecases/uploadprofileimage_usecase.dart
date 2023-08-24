import 'package:courses_app/core/error/failure.dart';
import 'package:courses_app/features/profile/domain/repository/profile_repository.dart';
import 'package:dartz/dartz.dart';

class UploadProfileImageUsecase {
  final ProfileRepository profileRepository;

  const UploadProfileImageUsecase(this.profileRepository);

  Future<Either<Failure, String>> call() async {
    return await profileRepository.uploadProfileImage();
  }
}
