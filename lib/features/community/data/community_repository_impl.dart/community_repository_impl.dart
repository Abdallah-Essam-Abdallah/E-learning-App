import 'package:courses_app/core/error/exception.dart';
import 'package:courses_app/core/error/failure.dart';
import 'package:courses_app/features/community/data/data_source/community_datasource.dart';
import 'package:courses_app/features/community/domain/entity/comment_entity.dart';
import 'package:courses_app/features/community/domain/entity/post_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/internet_connection.dart';
import '../../../../core/utils/appstrings.dart';
import '../../domain/repository/community_repository.dart';

class CommunityRepositoryImpl extends CommunityRepository {
  final CommunityDataSource communityDataSource;
  final InternetConnection internetConnection;

  CommunityRepositoryImpl(this.communityDataSource, this.internetConnection);

  @override
  Future<Either<Failure, Unit>> addComment(
      {required String postId,
      required String userId,
      required String text,
      required String commentingTime,
      required String userName,
      required String userImage}) async {
    if (await internetConnection.isInternetConnected) {
      try {
        await communityDataSource.addComment(
            postId: postId,
            userId: userId,
            text: text,
            commentingTime: commentingTime,
            userName: userName,
            userImage: userImage);
        return right(unit);
      } on AddCommentException catch (e) {
        return left(AddCommentFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> addLike({required PostEntity post}) async {
    if (await internetConnection.isInternetConnected) {
      try {
        await communityDataSource.addLike(post: post);
        return right(unit);
      } on AddLikeException catch (e) {
        return left(AddLikeFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(
      {required String text,
      String? image,
      required String userName,
      required String userImage}) async {
    if (await internetConnection.isInternetConnected) {
      try {
        await communityDataSource.addPost(
          text: text,
          image: image ?? '',
          userName: userName,
          userImage: userImage,
        );
        return right(unit);
      } on AddPostException catch (e) {
        return left(AddPostFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Stream<List<PostEntity>> getPosts() {
    return communityDataSource.getPosts();
  }

  @override
  Future<Either<Failure, String>> uploadPostImage() async {
    if (await internetConnection.isInternetConnected) {
      try {
        String imageUrl = await communityDataSource.uploadPostImage();
        return right(imageUrl);
      } on NoImageChoosedException catch (e) {
        return left(NoImageChoosedFaliure(e.message));
      } on ImageUplodedException catch (e) {
        return left(ImageUplodedFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Stream<List<CommentEntity>> getComments({required String postId}) {
    return communityDataSource.getComments(postId: postId);
  }
}
