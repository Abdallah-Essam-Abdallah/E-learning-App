import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/dateformater.dart';
import '../../domain/entity/message_entity.dart';

class VoiceMessageWidget extends StatefulWidget {
  const VoiceMessageWidget({Key? key, required this.message}) : super(key: key);
  final MessageEntity message;

  @override
  VoiceMessageWidgetState createState() => VoiceMessageWidgetState();
}

class VoiceMessageWidgetState extends State<VoiceMessageWidget> {
  AudioPlayer audioPlayer = AudioPlayer();
  Duration _audioDuration = Duration.zero;
  Duration _audioPosition = Duration.zero;
  bool _isAudioPlaying = false;

  @override
  void initState() {
    super.initState();

    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _audioDuration = duration;
      });
    });
    audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _audioPosition = position;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: IconButton(
            onPressed: () async {
              if (_isAudioPlaying) {
                await audioPlayer.pause();
              } else {
                await audioPlayer.play(UrlSource(widget.message.message));
              }
              setState(() {
                _isAudioPlaying = !_isAudioPlaying;
              });
            },
            icon: _isAudioPlaying &&
                    _audioPosition.inSeconds.toDouble() !=
                        _audioDuration.inSeconds.toDouble()
                ? Icon(
                    Icons.pause,
                    color: const Color.fromARGB(255, 236, 232, 232),
                    size: Responsive.getWidth(context) * .07,
                  )
                : Icon(
                    Icons.play_arrow,
                    color: const Color.fromARGB(255, 236, 232, 232),
                    size: Responsive.getWidth(context) * .07,
                  ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Slider.adaptive(
                  thumbColor: const Color.fromARGB(255, 236, 232, 232),
                  activeColor: const Color.fromARGB(255, 236, 232, 232),
                  inactiveColor: const Color.fromARGB(255, 121, 120, 120),
                  min: 0,
                  max: _audioDuration.inSeconds.toDouble(),
                  value: _audioPosition.inSeconds.toDouble() ==
                          _audioDuration.inSeconds.toDouble()
                      ? 0
                      : _audioPosition.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await audioPlayer.seek(position);
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    !_isAudioPlaying
                        ? DateFormater.formatTime(_audioDuration)
                        : DateFormater.formatTime(
                            _audioDuration - _audioPosition),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  AutoSizeText(
                    DateFormater.getTime(widget.message),
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.left,
                    minFontSize: 10,
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
