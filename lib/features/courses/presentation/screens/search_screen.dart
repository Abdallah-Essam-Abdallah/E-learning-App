import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/components/snack_bar.dart';
import 'package:courses_app/core/components/text_form_field.dart';
import 'package:courses_app/core/utils/appstrings.dart';
import 'package:courses_app/core/utils/responsive.dart';
import 'package:courses_app/features/courses/presentation/controller/courses_bloc/courses_bloc.dart';
import 'package:courses_app/features/courses/presentation/widgets/course_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'course_details_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(AppStrings.search),
      ),
      body: Padding(
          padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
          child: Column(children: [
            AppTextFormField(
              hintText: AppStrings.search,
              prefixIcon: const Icon(Icons.search_outlined),
              obscureText: false,
              keyboardType: TextInputType.text,
              onChanged: (value) => BlocProvider.of<CoursesBloc>(context)
                  .add(GetCoursesBySearchEvent(value)),
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .02,
            ),
            BlocConsumer<CoursesBloc, CoursesState>(
              listener: (context, state) {
                if (state is GetCoursesBySearchErrorState) {
                  showSnackBar(state.error, context);
                }
              },
              builder: (context, state) {
                if (state is GetCoursesBySearchLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is GetCoursesBySearchLoadedState) {
                  {
                    return Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => CourseDetailsScreen(
                                          course: state.coursesBySearch[index],
                                        ))));
                          },
                          child: CourseCard(
                              imageUrl: state.coursesBySearch[index].image,
                              title: state.coursesBySearch[index].title,
                              price: state.coursesBySearch[index].price,
                              rating: state.coursesBySearch[index].rating),
                        ),
                        itemCount: state.coursesBySearch.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                      ),
                    );
                  }
                } else {
                  return const SizedBox();
                }
              },
            )
          ])),
    );
  }
}
