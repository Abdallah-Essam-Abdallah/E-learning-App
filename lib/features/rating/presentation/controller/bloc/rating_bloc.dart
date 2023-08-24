import 'package:bloc/bloc.dart';
import 'package:courses_app/features/rating/domain/entity/rating_entity.dart';
import 'package:courses_app/features/rating/domain/usecases/addrating_usecase.dart';
import 'package:courses_app/features/rating/domain/usecases/getraing_usecase.dart';
import 'package:equatable/equatable.dart';

part 'rating_event.dart';
part 'rating_state.dart';

class RatingBloc extends Bloc<RatingEvent, RatingState> {
  final AddRatingUseCase addRatingUseCase;
  final GetRatingUseCase getRatingUseCase;
  double initialRating = 0;
  String ratingFeedbak = '';

  RatingBloc({required this.addRatingUseCase, required this.getRatingUseCase})
      : super(RatingInitial()) {
    on<AddRatingEvent>((event, emit) async {
      emit(AddRatingLoadingState());
      final result = await addRatingUseCase.call(
          comment: event.comment,
          course: event.course,
          stars: event.stars,
          userName: event.userName,
          userImage: event.userImage);
      result
          .fold((faliure) => emit(AddRatingErrorState(error: faliure.message)),
              (success) {
        emit(AddRatingLoadedState());
      });
    });

    on<GetRatingEvent>((event, emit) async {
      emit(GetRatingLoadingState());
      final result = await getRatingUseCase.call(
        course: event.course,
      );
      result
          .fold((faliure) => emit(GetRatingErrorState(error: faliure.message)),
              (success) {
        emit(GetRatingLoadedState(ratings: success));
      });
    });

    on<UpdateRatingValueEvent>((event, emit) async {
      emit(UpdateRatingValueLoadingState());
      initialRating = event.ratingValue;
      emit(UpdateRatingValueLoadedState());
    });

    on<UpdateRatingCommentEvent>((event, emit) async {
      emit(UpdateRatingCommentLoadingState());
      ratingFeedbak = event.ratingComment;
      emit(UpdateRatingCommentLoadedState());
    });
  }
}
