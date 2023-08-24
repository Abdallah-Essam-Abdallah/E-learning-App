import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String text;
  final String? image;
  final String userId;
  final String postId;
  final String postingTime;
  final String userName;
  final String userImage;
  final List likes;
  final int comments;

  const PostEntity({
    required this.text,
    this.image,
    required this.userId,
    required this.postId,
    required this.postingTime,
    required this.userName,
    required this.userImage,
    required this.likes,
    required this.comments,
  });

  @override
  List<Object?> get props => [
        text,
        image,
        userId,
        postId,
        userName,
        userImage,
        postingTime,
        likes,
        comments,
      ];
}
