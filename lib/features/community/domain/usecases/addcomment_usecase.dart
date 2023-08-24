import 'package:courses_app/features/community/domain/repository/community_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';

class AddCommentUseCase {
  final CommunityRepository communityRepository;

  const AddCommentUseCase(this.communityRepository);

  Future<Either<Failure, Unit>> call(
      {required String postId,
      required String userId,
      required String text,
      required String commentingTime,
      required String userName,
      required String userImage}) async {
    return await communityRepository.addComment(
        postId: postId,
        userId: userId,
        text: text,
        commentingTime: commentingTime,
        userName: userName,
        userImage: userImage);
  }
}
