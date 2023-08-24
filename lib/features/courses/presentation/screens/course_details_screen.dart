import 'package:courses_app/core/utils/responsive.dart';
import 'package:courses_app/features/courses/presentation/widgets/course_details_background.dart';
import 'package:courses_app/features/courses/presentation/widgets/course_details_card.dart';
import 'package:courses_app/features/favorites/presentation/favorites_bloc/favorites_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/course_entity.dart';

class CourseDetailsScreen extends StatelessWidget {
  const CourseDetailsScreen({super.key, required this.course});
  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
    return Scaffold(
        body: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CourseDetailsBackground(imageUrl: course.image),
        Positioned(
            top: Responsive.getHeight(context) * .05,
            left: Responsive.getWidth(context) * .03,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back))),
        Positioned(
          top: Responsive.getHeight(context) * .05,
          right: Responsive.getWidth(context) * .03,
          child: CircleAvatar(
            radius: Responsive.getWidth(context) * .05,
            backgroundColor: const Color.fromARGB(120, 255, 255, 255),
            child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                return IconButton(
                    onPressed: () {
                      BlocProvider.of<FavoritesBloc>(context).add(
                          AddCourseToFavoriresEvent(
                              course: course, isFavorite: course.isFavorite));
                    },
                    icon: !course.isFavorite &&
                            !favoritesBloc.favoriteCourses.contains(course)
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
        CourseDetailsCard(
            title: course.title,
            description: course.description,
            rating: course.rating,
            time: course.time,
            price: course.price)
      ],
    ));
  }
}
