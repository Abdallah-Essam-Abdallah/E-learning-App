import 'package:courses_app/core/error/failure.dart';
import 'package:courses_app/features/community/domain/repository/community_repository.dart';

import 'package:dartz/dartz.dart';

class UploadPostImageUsecase {
  final CommunityRepository communityRepository;

  const UploadPostImageUsecase(this.communityRepository);

  Future<Either<Failure, String>> call() async {
    return await communityRepository.uploadPostImage();
  }
}
