import '../../domain/entity/post_entity.dart';

class PostModel extends PostEntity {
  const PostModel({
    required super.userImage,
    required super.text,
    required super.postId,
    required super.postingTime,
    required super.likes,
    required super.comments,
    required super.userId,
    required super.userName,
    super.image,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userImage: json['userImage'],
        text: json['text'],
        postId: json['postId'],
        postingTime: json['postingTime'],
        likes: json['likes'],
        comments: json['comments'] ?? 0,
        userId: json['userId'],
        userName: json['userName'],
        image: json['image'],
      );

  Map<String, dynamic> toJson() => {
        'userImage': userImage,
        'text': text,
        'postId': postId,
        'postingTime': postingTime,
        'likes': likes,
        'comments': comments,
        'userId': userId,
        'userName': userName,
        'image': image,
      };
}
