import 'package:courses_app/features/community/domain/repository/community_repository.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class AddPostUseCase {
  final CommunityRepository communityRepository;

  const AddPostUseCase(this.communityRepository);

  Future<Either<Failure, Unit>> call(
      {required String text,
      String? image,
      required String userName,
      required String userImage}) async {
    return await communityRepository.addPost(
        text: text,
        userName: userName,
        userImage: userImage,
        image: image ?? '');
  }
}
