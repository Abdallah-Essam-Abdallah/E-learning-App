import 'package:courses_app/features/community/domain/repository/community_repository.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entity/post_entity.dart';

class AddLikeUseCase {
  final CommunityRepository communityRepository;

  const AddLikeUseCase(this.communityRepository);

  Future<Either<Failure, Unit>> call({required PostEntity post}) async {
    return await communityRepository.addLike(post: post);
  }
}
