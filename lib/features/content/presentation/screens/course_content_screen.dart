import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/utils/appstrings.dart';

import 'package:courses_app/features/content/domain/entity/video_entity.dart';
import 'package:courses_app/features/content/presentation/widgets/tab_bar.dart';

import 'package:courses_app/features/content/presentation/widgets/videos_player_widget.dart';

import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

class CourseContentScreen extends StatefulWidget {
  const CourseContentScreen(
      {Key? key, required this.videos, required this.course})
      : super(key: key);
  final List<VideoEntity> videos;
  final String course;

  @override
  State<CourseContentScreen> createState() => _CourseContentScreenState();
}

class _CourseContentScreenState extends State<CourseContentScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  VideoPlayerController? videoController;

  final bool isFullScreen = false;

  void play({int index = 0, bool init = false}) {
    if (index < 0 || index >= widget.videos.length) return;
    if (videoController != null && !init) {
      videoController!.pause();
    }
    setState(() {
      currentIndex = index;
    });
    videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.videos[currentIndex].url));
    videoController!
      ..addListener(() {
        setState(() {});
      })
      ..initialize().then((value) => videoController!.play());
  }

  @override
  void initState() {
    play(init: true);

    super.initState();
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(AppStrings.content),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          VideosPlayerWidget(
            videoController: videoController!,
            isFullScreen: isFullScreen,
          ),
          Expanded(
            child: TabBarWidget(
              videos: widget.videos,
              course: widget.course,
              videoController: videoController!,
              onPlay: play,
            ),
          ),
        ],
      ),
    );
  }
}
