import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/utils/dateformater.dart';
import '../../../../core/utils/responsive.dart';

import '../screens/landscapevideoplayer.dart';

class VideosPlayerWidget extends StatefulWidget {
  const VideosPlayerWidget({
    super.key,
    required this.videoController,
    required this.isFullScreen,
  });
  final VideoPlayerController videoController;
  final bool isFullScreen;

  @override
  State<VideosPlayerWidget> createState() => _VideosPlayerWidgetState();
}

class _VideosPlayerWidgetState extends State<VideosPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.videoController.value.isInitialized
            ? InkWell(
                onTap: () {
                  widget.videoController.value.isPlaying
                      ? widget.videoController.pause()
                      : widget.videoController.play();
                },
                child: SizedBox(
                  height: !widget.isFullScreen
                      ? Responsive.getHeight(context) * 0.35
                      : Responsive.getHeight(context),
                  child: Stack(alignment: Alignment.bottomCenter, children: [
                    VideoPlayer(widget.videoController),
                    Visibility(
                        visible: !widget.videoController.value.isPlaying,
                        replacement: const SizedBox(),
                        child: Container(
                          color: const Color.fromARGB(131, 0, 0, 0),
                          height: !widget.isFullScreen
                              ? Responsive.getHeight(context) * 0.35
                              : Responsive.getHeight(context),
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              size: Responsive.getWidth(context) * 0.10,
                              color: const Color.fromARGB(164, 255, 255, 255),
                            ),
                          ),
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ValueListenableBuilder(
                                valueListenable: widget.videoController,
                                builder:
                                    (context, VideoPlayerValue value, child) {
                                  return AutoSizeText(
                                      DateFormater.formatTime(value.position),
                                      style:
                                          const TextStyle(color: Colors.white));
                                }),
                            SizedBox(
                              width: Responsive.getWidth(context) * .01,
                            ),
                            Expanded(
                              child: SizedBox(
                                height: !widget.isFullScreen
                                    ? Responsive.getHeight(context) * 0.01
                                    : Responsive.getHeight(context) * 0.02,
                                child: VideoProgressIndicator(
                                    widget.videoController,
                                    allowScrubbing: true),
                              ),
                            ),
                            SizedBox(
                              width: Responsive.getWidth(context) * .01,
                            ),
                            AutoSizeText(
                              DateFormater.formatTime(
                                  widget.videoController.value.duration),
                              style: const TextStyle(color: Colors.white),
                            ),
                            IconButton(
                                onPressed: () {
                                  if (!widget.isFullScreen) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                LandscapeVideoPlayer(
                                                  controller:
                                                      widget.videoController,
                                                ))));
                                  } else {
                                    Navigator.pop(context);
                                  }
                                },
                                icon: !widget.isFullScreen
                                    ? const Icon(
                                        Icons.fullscreen,
                                        color: Colors.white,
                                      )
                                    : const Icon(
                                        Icons.fullscreen_exit,
                                        color: Colors.white,
                                      )),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
              )
            : SizedBox(
                height: Responsive.getHeight(context) * 0.35,
                child: const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              ),
      ],
    );
  }
}
