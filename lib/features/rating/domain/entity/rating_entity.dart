import 'package:equatable/equatable.dart';

class RatingEntity extends Equatable {
  final String comment;
  final String userId;
  final double stars;
  final String userName;
  final String userImage;

  const RatingEntity({
    required this.comment,
    required this.userId,
    required this.stars,
    required this.userName,
    required this.userImage,
  });

  @override
  List<Object?> get props => [comment, userId, stars, userName, userImage];
}
