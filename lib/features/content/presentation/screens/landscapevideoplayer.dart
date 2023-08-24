import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import '../widgets/videos_player_widget.dart';

class LandscapeVideoPlayer extends StatefulWidget {
  const LandscapeVideoPlayer({super.key, required this.controller});
  final VideoPlayerController controller;
  @override
  State<LandscapeVideoPlayer> createState() => _LandscapeVideoPlayerState();
}

class _LandscapeVideoPlayerState extends State<LandscapeVideoPlayer> {
  final bool isFullScreen = true;

  Future landscapeMode() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  Future resetOrientation() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void initState() {
    landscapeMode();
    super.initState();
  }

  @override
  void dispose() {
    resetOrientation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideosPlayerWidget(
        videoController: widget.controller,
        isFullScreen: isFullScreen,
      ),
    );
  }
}
