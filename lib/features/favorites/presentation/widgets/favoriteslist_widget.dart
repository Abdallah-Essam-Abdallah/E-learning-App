import 'package:courses_app/core/utils/appstrings.dart';
import 'package:courses_app/features/courses/presentation/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/responsive.dart';
import '../favorites_bloc/favorites_bloc.dart';

class FavoritesListWidget extends StatelessWidget {
  const FavoritesListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      buildWhen: (previous, current) {
        return previous is GetFavoriteCoursesLoadingState;
      },
      builder: (context, state) {
        if (state is GetFavoriteCoursesLoadingState) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is GetFavoriteCoursesLoadedState) {
          return Padding(
            padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
            child: ListView.separated(
              itemCount: state.courses.length,
              itemBuilder: (context, index) {
                return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) =>
                        BlocProvider.of<FavoritesBloc>(context).add(
                            AddCourseToFavoriresEvent(
                                course: state.courses[index],
                                isFavorite: state.courses[index].isFavorite)),
                    background: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.delete, color: Colors.white),
                            Text(AppStrings.deleteFromFavorites,
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    child: CourseCard(
                        imageUrl: state.courses[index].image,
                        title: state.courses[index].title,
                        price: state.courses[index].price,
                        rating: state.courses[index].rating));
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
