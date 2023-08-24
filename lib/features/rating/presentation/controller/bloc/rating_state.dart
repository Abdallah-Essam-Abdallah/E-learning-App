part of 'rating_bloc.dart';

abstract class RatingState extends Equatable {
  const RatingState();

  @override
  List<Object> get props => [];
}

class RatingInitial extends RatingState {}

class AddRatingLoadingState extends RatingState {}

class AddRatingLoadedState extends RatingState {}

class AddRatingErrorState extends RatingState {
  final String error;

  const AddRatingErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class GetRatingLoadingState extends RatingState {}

class GetRatingLoadedState extends RatingState {
  final List<RatingEntity> ratings;

  const GetRatingLoadedState({required this.ratings});
  @override
  List<Object> get props => [ratings];
}

class GetRatingErrorState extends RatingState {
  final String error;

  const GetRatingErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class UpdateRatingValueLoadingState extends RatingState {}

class UpdateRatingValueLoadedState extends RatingState {}

class UpdateRatingCommentLoadingState extends RatingState {}

class UpdateRatingCommentLoadedState extends RatingState {}
