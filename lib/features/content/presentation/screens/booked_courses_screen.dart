import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:courses_app/core/utils/responsive.dart';

import 'package:courses_app/features/content/presentation/widgets/no_bookedcourses_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/content_bloc/content_bloc.dart';
import '/core/dependency_injection/injection.dart' as di;

class BookedCoursesScreen extends StatelessWidget {
  const BookedCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.getIt<ContentBloc>()..add(GetBookedCoursesEvent()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<ContentBloc, ContentState>(
          builder: (context, state) {
            if (state is GetBookedCoursesLoadingState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is GetBookedCoursesLoadedState) {
              if (state.courses.isNotEmpty) {
                return Padding(
                  padding: EdgeInsets.all(
                    Responsive.getWidth(context) * .01,
                  ),
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {},
                          title: AutoSizeText(
                            state.courses[index].title,
                            style: Theme.of(context).textTheme.titleLarge,
                            maxLines: 1,
                          ),
                          subtitle: AutoSizeText(
                            state.courses[index].author,
                            style: const TextStyle(
                                color: Color.fromARGB(192, 95, 91, 91)),
                          ),
                          leading: CircleAvatar(
                            radius: Responsive.getWidth(context) * .10,
                            backgroundImage: CachedNetworkImageProvider(
                              state.courses[index].image,
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const Divider(
                            thickness: 1,
                          ),
                      itemCount: state.courses.length),
                );
              } else {
                return const NoBookedCoursesWidget();
              }
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
