import 'package:bloc/bloc.dart';
import 'package:courses_app/features/content/domain/usecases/getbookedcourses_usecase.dart';
import 'package:courses_app/features/content/domain/usecases/playvideo_usecase.dart';
import 'package:courses_app/features/courses/domain/entity/course_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';
part 'content_event.dart';
part 'content_state.dart';

class ContentBloc extends Bloc<ContentEvent, ContentState> {
  final PlayVideoUseCase playVideoUseCase;
  final GetBookedCoursesUseCase getBookedCoursesUseCase;
  int currentIndex = 0;
  VideoPlayerController? videoController;
  ContentBloc({
    required this.playVideoUseCase,
    required this.getBookedCoursesUseCase,
  }) : super(ContentInitial()) {
    on<GetBookedCoursesEvent>((event, emit) async {
      emit(GetBookedCoursesLoadingState());
      final result = await getBookedCoursesUseCase.call();
      result.fold(
          (faliure) => emit(GetBookedCoursesErrorState(error: faliure.message)),
          (success) {
        emit(GetBookedCoursesLoadedState(courses: success));
      });
    });
  }
}
