import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:courses_app/features/content/domain/entity/video_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';

class VideosList extends StatelessWidget {
  const VideosList({
    super.key,
    required this.videos,
    required this.onPlay,
  });
  final List<VideoEntity> videos;
  final Function({int index, bool init}) onPlay;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.getWidth(context) * 0.01),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              onPlay(index: index);
            },
            title: AutoSizeText(
              videos[index].name,
              maxLines: 1,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            leading: CircleAvatar(
              radius: Responsive.getWidth(context) * .10,
              backgroundImage:
                  CachedNetworkImageProvider(videos[index].thumbnail),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(thickness: 1),
        itemCount: videos.length,
      ),
    );
  }
}
