import 'package:bloc/bloc.dart';
import 'package:courses_app/features/courses/domain/usecases/getcoursesbycategory_usecase.dart';
import 'package:courses_app/features/courses/domain/usecases/getcoursesbysearch_usecase.dart';
import 'package:courses_app/features/courses/domain/usecases/gettoprated_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/course_entity.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  final GetCoursesByCategoryUseCase getCoursesByCategoryUseCase;
  final GetTopRatedCoursesUseCase getTopRatedCoursesUseCase;

  final GetCoursesBySearchUseCase getCoursesBySearchUseCase;

  CoursesBloc({
    required this.getCoursesByCategoryUseCase,
    required this.getTopRatedCoursesUseCase,
    required this.getCoursesBySearchUseCase,
  }) : super(CoursesInitial()) {
    on<CoursesEvent>((event, emit) async {
      if (event is GetCoursesByCategoryEvent) {
        emit(GetCoursesByCategoryLoadingState());
        final response =
            await getCoursesByCategoryUseCase.call(category: event.category);
        response.fold(
            (faliure) =>
                emit(GetCoursesByCategoryErrorState(error: faliure.message)),
            (success) => emit(
                GetCoursesByCategoryLoadedState(coursesByCategory: success)));
      } else if (event is GetTopRatedCoursesEvent) {
        emit(CoursesInitial());
        emit(GetTopRatedCoursesLoadingState());
        final response = await getTopRatedCoursesUseCase.call();
        response.fold(
            (faliure) =>
                emit(GetTopRatedCoursesErrorState(error: faliure.message)),
            (success) =>
                emit(GetTopRatedCoursesLoadedState(topRatedCourses: success)));
      } else if (event is GetCoursesBySearchEvent) {
        emit(GetCoursesBySearchLoadingState());
        final response = await getCoursesBySearchUseCase.call(
            searchValue: event.searchValue);
        response.fold(
            (faliure) =>
                emit(GetCoursesBySearchErrorState(error: faliure.message)),
            (success) =>
                emit(GetCoursesBySearchLoadedState(coursesBySearch: success)));
      }
    });
  }
}
