import 'package:courses_app/features/community/domain/repository/community_repository.dart';
import '../entity/post_entity.dart';

class GetPostsUseCase {
  final CommunityRepository communityRepository;

  const GetPostsUseCase(this.communityRepository);

  Stream<List<PostEntity>> call() {
    return communityRepository.getPosts();
  }
}
