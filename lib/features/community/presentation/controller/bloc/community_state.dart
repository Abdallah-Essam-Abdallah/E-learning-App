part of 'community_bloc.dart';

class CommunityState extends Equatable {
  const CommunityState();

  @override
  List<Object> get props => [];
}

class CommunityInitial extends CommunityState {}

class AddPostloadingState extends CommunityState {}

class AddPostloadedState extends CommunityState {}

class AddPostErrorState extends CommunityState {
  final String error;

  const AddPostErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class UploadPostImageLoadingState extends CommunityState {}

class UploadPostImageLoadedState extends CommunityState {}

class UploadPostImageErrorState extends CommunityState {
  final String error;

  const UploadPostImageErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class GetPostsloadingState extends CommunityState {}

class GetPostsloadedState extends CommunityState {
  final List<PostEntity> posts;

  const GetPostsloadedState({required this.posts});

  @override
  List<Object> get props => [posts];
}

class GetPostsErrorState extends CommunityState {
  final String error;

  const GetPostsErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class AddLikeloadingState extends CommunityState {}

class AddLikeloadedState extends CommunityState {}

class AddLikeErrorState extends CommunityState {
  final String error;

  const AddLikeErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class AddCommentloadingState extends CommunityState {}

class AddCommentloadedState extends CommunityState {}

class AddCommentErrorState extends CommunityState {
  final String error;

  const AddCommentErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class GetCommentsloadingState extends CommunityState {}

class GetCommentsloadedState extends CommunityState {
  final List<CommentEntity> comments;

  const GetCommentsloadedState({required this.comments});

  @override
  List<Object> get props => [comments];
}

class GetCommentsErrorState extends CommunityState {
  final String error;

  const GetCommentsErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
