/*import 'package:auto_size_text/auto_size_text.dart';SS
import 'package:courses_app/core/utils/responsive.dart';
import 'package:courses_app/features/content/presentation/controller/content_bloc/content_bloc.dart';
import 'package:courses_app/features/courses/data/model/course_model.dart';
import 'package:courses_app/features/courses/domain/entity/course_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/dependency_injection/injection.dart' as di;

class BokedCourseScreen extends StatelessWidget {
  const BokedCourseScreen({super.key, required this.course});
  final CourseEntity course;

  /* late VideoPlayerController videoController =
      VideoPlayerController.networkUrl(Uri.parse(''));
  int currentIndex = 0;
  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }*/

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            di.getIt<ContentBloc>()..add(GetVideosEvent(course)),
        child: Scaffold(
            appBar: AppBar(),
            body: /*Column(
              children: [
                Container(
                    color: Colors.indigo,
                    height: Responsive.getHeight(context) * .25,
                    width: Responsive.getWidth(context),
                    child: //controller.value.isInitialized
                        //?
                        InkWell(
                      child: BlocBuilder<ContentBloc, ContentState>(
                        builder: (context, state) {
                          if (state is PlayVideoLoadingState) {
                            return const CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            );
                          }
                          return VideoPlayer(videoController);
                        },
                      ),
                      onTap: () {
                        di
                            .getIt<ContentBloc>()
                            .add(PlayVideoEvent(controller: videoController));
                      },
                    )
                    /*: const Center(
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            ),
                          ),*/
                    ),
                SizedBox(
                  height: Responsive.getHeight(context) * .01,
                ),
                VideoProgressIndicator(videoController, allowScrubbing: true),
                SizedBox(
                  height: Responsive.getHeight(context) * .05,
                ),*/
                BlocBuilder<ContentBloc, ContentState>(
                    builder: (context, state) {
              if (state is GetVideosLoadingState) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is GetVideosLoadedState) {
                return Padding(
                  padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          /* setState(() {
                                videoController =
                                    VideoPlayerController.networkUrl(
                                        Uri.parse(state.videos[index].url));
                              });
                              di.getIt<ContentBloc>().add(
                                  PlayVideoEvent(controller: videoController));*/
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        state.videos[index].thumbnail,
                                      ))),
                              width: Responsive.getWidth(context) * .40,
                              height: Responsive.getHeight(context) * .10,
                            ),
                            SizedBox(width: Responsive.getWidth(context) * .02),
                            Expanded(
                                child: AutoSizeText(
                              state.videos[index].name,
                              maxLines: 1,
                              style: Theme.of(context).textTheme.displayMedium,
                            ))
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                    ),
                    itemCount: state.videos.length,
                  ),
                );
              } else {
                return const SizedBox();
              }
            })));
  }
}
        
      
    
  

/*class BokedCourseScreen extends StatefulWidget {
  const BokedCourseScreen({super.key, required this.course});
  final String course;

  @override
  State<BokedCourseScreen> createState() => _BokedCourseScreenState();
}

class _BokedCourseScreenState extends State<BokedCourseScreen> {
  late final VideoPlayerController videoController;

  @override
  void initState() {
    // di.getIt<ContentBloc>().add(GetVideosEvent(widget.course));
    di.getIt<ContentBloc>().add(PlayVideoEvent(
        url: ContentBloc.videos[0].url, controller: videoController));
    super.initState();
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(children: [
          Container(
            color: Colors.indigo,
            height: Responsive.getHeight(context) * .25,
            width: Responsive.getWidth(context),
            child: videoController.value.isInitialized
                ? VideoPlayer(videoController)
                : const Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.white,
                    ),
                  ),
          ),
          SizedBox(
            height: Responsive.getHeight(context) * .01,
          ),
          VideoProgressIndicator(videoController, allowScrubbing: true),
          SizedBox(
            height: Responsive.getHeight(context) * .05,
          ),
        ]));
  }
}*/*/
