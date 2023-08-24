import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:courses_app/features/courses/presentation/screens/course_details_screen.dart';

import 'package:courses_app/features/favorites/presentation/favorites_bloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/responsive.dart';
import '../../domain/entity/course_entity.dart';
import '../controller/courses_bloc/courses_bloc.dart';

class TopRatedWidget extends StatelessWidget {
  const TopRatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
    return BlocProvider.value(
      value: BlocProvider.of<CoursesBloc>(context)
        ..add(GetTopRatedCoursesEvent()),
      child: SizedBox(
        height: Responsive.getHeight(context) * .25,
        child: BlocBuilder<CoursesBloc, CoursesState>(
          buildWhen: (previous, current) {
            return previous is GetTopRatedCoursesLoadingState ||
                current is GetTopRatedCoursesLoadedState;
          },
          builder: (context, state) {
            if (state is GetTopRatedCoursesLoadingState) {
              return Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[400]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    height: Responsive.getHeight(context) * .25,
                    width: Responsive.getWidth(context) * .50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              );
            } else if (state is GetTopRatedCoursesLoadedState) {
              final List<CourseEntity> topRatedCourses = state.topRatedCourses;

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final double containerHieght =
                      Responsive.getHeight(context) * .25;
                  final double containerWidth =
                      Responsive.getWidth(context) * .35;
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.bottomToTop,
                              child: CourseDetailsScreen(
                                course: state.topRatedCourses[index],
                              )));
                    },
                    child: CachedNetworkImage(
                      imageUrl: state.topRatedCourses[index].image,
                      width: containerWidth,
                      height: containerHieght,
                      imageBuilder: (context, imageProvider) => LayoutBuilder(
                        builder: (BuildContext context,
                                BoxConstraints constraints) =>
                            Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                              Container(
                                width: containerWidth,
                                height: containerHieght,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.fill),
                                ),
                              ),
                              Positioned(
                                right: containerWidth * .03,
                                top: containerHieght * .03,
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor:
                                      const Color.fromARGB(120, 255, 255, 255),
                                  child: BlocBuilder<FavoritesBloc,
                                      FavoritesState>(
                                    builder: (context, state) {
                                      return IconButton(
                                          onPressed: () {
                                            BlocProvider.of<FavoritesBloc>(
                                                    context)
                                                .add(AddCourseToFavoriresEvent(
                                                    course:
                                                        topRatedCourses[index],
                                                    isFavorite:
                                                        topRatedCourses[index]
                                                            .isFavorite));
                                          },
                                          icon: !topRatedCourses[index]
                                                      .isFavorite &&
                                                  !favoritesBloc.favoriteCourses
                                                      .contains(topRatedCourses[
                                                          index])
                                              ? const Icon(
                                                  Icons.favorite_outline,
                                                  color: Colors.black,
                                                )
                                              : const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                ));
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Color.fromARGB(129, 56, 47, 47),
                                ),
                                height: Responsive.getHeight(context) * .05,
                                width: Responsive.getWidth(context) * .50,
                                child: Center(
                                  child: AutoSizeText(
                                    topRatedCourses[index].title,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[200]!,
                        child: Container(
                          height: Responsive.getHeight(context) * .25,
                          width: Responsive.getWidth(context) * .50,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  );
                },
                itemCount: 4,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: Responsive.getWidth(context) * .02,
                  );
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
