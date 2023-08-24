import '../../domain/entity/comment_entity.dart';

class CommentModel extends CommentEntity {
  const CommentModel(
      {required super.text,
      required super.userId,
      required super.postId,
      required super.commentingTime,
      required super.userName,
      required super.userImage});

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        userImage: json['userImage'],
        text: json['text'],
        postId: json['postId'],
        userId: json['userId'],
        userName: json['userName'],
        commentingTime: json['commentingTime'],
      );

  Map<String, dynamic> toJson() => {
        'userImage': userImage,
        'text': text,
        'postId': postId,
        'userId': userId,
        'userName': userName,
        'commentingTime': commentingTime,
      };
}
