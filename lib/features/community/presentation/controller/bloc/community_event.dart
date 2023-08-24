part of 'community_bloc.dart';

class CommunityEvent extends Equatable {
  const CommunityEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends CommunityEvent {
  final String text;
  final String? image;
  final String userName;
  final String userImage;

  const AddPostEvent(
      {required this.text,
      required this.userName,
      required this.userImage,
      this.image});
  @override
  List<Object> get props => [text, userName, userImage, image ?? ''];
}

class UploadPostImageEvent extends CommunityEvent {}

class GetPostsEvent extends CommunityEvent {}

class AddLikeEvent extends CommunityEvent {
  final PostEntity post;

  const AddLikeEvent({
    required this.post,
  });

  @override
  List<Object> get props => [
        post,
      ];
}

class AddCommentEvent extends CommunityEvent {
  final String postId;
  final String userId;
  final String text;
  final String userName;
  final String userImage;
  final String commentingTime;

  const AddCommentEvent({
    required this.postId,
    required this.userId,
    required this.text,
    required this.userName,
    required this.userImage,
    required this.commentingTime,
  });
  @override
  List<Object> get props =>
      [postId, userId, text, userName, userImage, commentingTime];
}

class GetCommentsEvent extends CommunityEvent {
  final String postId;

  const GetCommentsEvent({required this.postId});
  @override
  List<Object> get props => [
        postId,
      ];
}
