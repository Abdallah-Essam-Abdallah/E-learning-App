import 'package:courses_app/features/community/domain/repository/community_repository.dart';
import '../entity/comment_entity.dart';

class GetCommentsUseCase {
  final CommunityRepository communityRepository;

  const GetCommentsUseCase(this.communityRepository);

  Stream<List<CommentEntity>> call({
    required String postId,
  }) {
    return communityRepository.getComments(
      postId: postId,
    );
  }
}
