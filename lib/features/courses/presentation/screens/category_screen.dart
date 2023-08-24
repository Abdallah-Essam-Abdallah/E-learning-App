import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/connectivity_cubit/internet_cubit.dart';
import 'package:courses_app/core/utils/responsive.dart';
import 'package:courses_app/features/courses/presentation/controller/courses_bloc/courses_bloc.dart';

import 'package:courses_app/features/courses/presentation/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/no_internet_widget.dart';
import 'course_details_screen.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CoursesBloc>(context)
        ..add(GetCoursesByCategoryEvent(category)),
      child: BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) {
          if (state is DisconnectedInternetState) {
            return const NoInternetWidget();
          } else {
            return Scaffold(
              appBar: AppBar(
                title: AutoSizeText(category),
              ),
              body: BlocBuilder<CoursesBloc, CoursesState>(
                builder: (context, state) {
                  if (state is GetCoursesByCategoryLoadingState) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (state is GetCoursesByCategoryLoadedState) {
                    return Padding(
                      padding:
                          EdgeInsets.all(Responsive.getWidth(context) * .02),
                      child: ListView.separated(
                          itemBuilder: (context, index) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              CourseDetailsScreen(
                                                course: state
                                                    .coursesByCategory[index],
                                              ))));
                                },
                                child: CourseCard(
                                    imageUrl:
                                        state.coursesByCategory[index].image,
                                    title: state.coursesByCategory[index].title,
                                    price: state.coursesByCategory[index].price,
                                    rating:
                                        state.coursesByCategory[index].rating),
                              ),
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: state.coursesByCategory.length),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}
