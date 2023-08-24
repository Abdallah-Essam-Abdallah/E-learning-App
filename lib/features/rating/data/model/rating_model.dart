import 'package:courses_app/features/rating/domain/entity/rating_entity.dart';

class RatingModel extends RatingEntity {
  const RatingModel(
      {required super.comment,
      required super.userId,
      required super.stars,
      required super.userName,
      required super.userImage});

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
        comment: json['comment'],
        userId: json['userId'],
        stars: json['stars'],
        userName: json['userName'],
        userImage: json['userImage'],
      );

  Map<String, dynamic> toJson() => {
        'comment': comment,
        'userId': userId,
        'stars': stars,
        'userName': userName,
        'userImage': userImage,
      };
}
