import 'package:courses_app/features/content/presentation/widgets/videos_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/utils/appstrings.dart';
import '../../../../core/utils/responsive.dart';
import '../../../rating/presentation/screens/rating_screen.dart';
import '../../domain/entity/video_entity.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({
    super.key,
    required this.videos,
    required this.course,
    required this.videoController,
    required this.onPlay,
  });
  final List<VideoEntity> videos;
  final String course;
  final VideoPlayerController videoController;
  final Function({int index, bool init}) onPlay;

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Responsive.getHeight(context) * .07,
          child: TabBar(
            labelColor: Colors.black,
            controller: tabController,
            tabs: const [
              Tab(
                text: AppStrings.content,
              ),
              Tab(
                text: AppStrings.ratings,
              ),
            ],
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: TabBarView(
              physics: const BouncingScrollPhysics(),
              controller: tabController,
              children: [
                Column(
                  children: [
                    SizedBox(height: Responsive.getHeight(context) * 0.02),
                    Expanded(
                        child: VideosList(
                      videos: widget.videos,
                      onPlay: widget.onPlay,
                    )),
                  ],
                ),
                RatingScreen(
                  course: widget.course,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
