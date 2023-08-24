import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String text;
  final String userId;
  final String postId;
  final String commentingTime;
  final String userName;
  final String userImage;

  const CommentEntity({
    required this.text,
    required this.userId,
    required this.postId,
    required this.commentingTime,
    required this.userName,
    required this.userImage,
  });

  @override
  List<Object?> get props => [
        text,
        userId,
        postId,
        userName,
        userImage,
        commentingTime,
      ];
}
