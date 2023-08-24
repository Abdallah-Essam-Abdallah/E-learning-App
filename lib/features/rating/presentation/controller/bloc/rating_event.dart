part of 'rating_bloc.dart';

abstract class RatingEvent extends Equatable {
  const RatingEvent();

  @override
  List<Object> get props => [];
}

class AddRatingEvent extends RatingEvent {
  final String comment;
  final double stars;
  final String course;
  final String userName;
  final String userImage;

  const AddRatingEvent({
    required this.comment,
    required this.stars,
    required this.course,
    required this.userName,
    required this.userImage,
  });

  @override
  List<Object> get props => [comment, stars, course, userName, userImage];
}

// ignore: must_be_immutable
class UpdateRatingValueEvent extends RatingEvent {
  double ratingValue = 0;

  UpdateRatingValueEvent({required this.ratingValue});
}

// ignore: must_be_immutable
class UpdateRatingCommentEvent extends RatingEvent {
  String ratingComment = '';

  UpdateRatingCommentEvent({required this.ratingComment});
}

class GetRatingEvent extends RatingEvent {
  final String course;

  const GetRatingEvent({required this.course});

  @override
  List<Object> get props => [course];
}
