import 'package:courses_app/features/community/domain/entity/post_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entity/comment_entity.dart';

abstract class CommunityRepository {
  Future<Either<Failure, Unit>> addPost(
      {required String text,
      String? image,
      required String userName,
      required String userImage});
  Future<Either<Failure, String>> uploadPostImage();
  Stream<List<PostEntity>> getPosts();

  Future<Either<Failure, Unit>> addLike({required PostEntity post});

  Future<Either<Failure, Unit>> addComment(
      {required String postId,
      required String userId,
      required String text,
      required String commentingTime,
      required String userName,
      required String userImage});
  Stream<List<CommentEntity>> getComments({required String postId});
}
