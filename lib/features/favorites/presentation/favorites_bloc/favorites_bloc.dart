import 'package:bloc/bloc.dart';
import 'package:courses_app/features/courses/data/model/course_model.dart';
import 'package:courses_app/features/favorites/domain/usecases/addcoursetofavorites_usecase.dart';
import 'package:courses_app/features/favorites/domain/usecases/getfavoritecourses_usecase.dart';
import 'package:equatable/equatable.dart';

import '../../../courses/domain/entity/course_entity.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  List<CourseEntity> favoriteCourses = [];
  final AddCourseToFavoriresUseCase addCourseToFavoriresUseCase;
  final GetFavoriteCoursesUseCase getFavoriteCoursesUseCase;

  FavoritesBloc({
    required this.addCourseToFavoriresUseCase,
    required this.getFavoriteCoursesUseCase,
  }) : super(FavoritesInitial()) {
    on<AddCourseToFavoriresEvent>((event, emit) async {
      emit(FavoritesInitial());
      if (!event.isFavorite && !favoriteCourses.contains(event.course)) {
        event.course.isFavorite = true;
        favoriteCourses.add(event.course);
        await addCourseToFavoriresUseCase.call(favoriteCourse: event.course);
        emit(AddCourseToFavoriresState());
      } else {
        event.course.isFavorite = false;
        favoriteCourses.remove(event.course);
        await addCourseToFavoriresUseCase.call(favoriteCourse: event.course);
        emit(RemoveCoursefromFavoriresState());
      }
    });

    on<GetFavoriteCoursesEvent>((event, emit) async {
      emit(FavoritesInitial());
      emit(GetFavoriteCoursesLoadingState());
      final response = await getFavoriteCoursesUseCase.call();
      response.fold(
          (left) => emit(GetFavoriteCoursesErrorState(error: left.message)),
          (result) {
        emit(GetFavoriteCoursesLoadedState(courses: result));
        favoriteCourses = result;
      });
    });
  }
}
