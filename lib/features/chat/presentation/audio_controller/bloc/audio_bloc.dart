import 'package:audioplayers/audioplayers.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioPlayer audioPlayer = AudioPlayer();
  bool isAudioPlaying = false;
  Duration audioDuration = Duration.zero;
  Duration audioPosition = Duration.zero;
  static AudioBloc getAudioBloc(context) => BlocProvider.of(context);

  AudioBloc() : super(AudioInitial()) {
    on<AudioPlayingEvent>((event, emit) async {
      emit(AudioPlayingIntialState());
      isAudioPlaying = !isAudioPlaying;
      isAudioPlaying
          ? await audioPlayer
              .play(UrlSource(event.audioUrl))
              .whenComplete(() => emit(AudioPlayingState()))
          : await audioPlayer
              .pause()
              .whenComplete(() => emit(AudioPlayingState()));
    });

    on<UpdateDurationEvent>((event, emit) {
      // emit(UpdateAudioDurationIntialState());
      audioPlayer.onDurationChanged.listen((newDuration) {
        audioDuration = newDuration;
        emit(UpdateAudioDurationState());
      });
    });

    on<UpdatePositionEvent>((event, emit) {
      //emit(UpdateAudioPositionIntialState());
      audioPlayer.onPositionChanged.listen((newPosition) {
        audioPosition = newPosition;
        emit(UpdateAudioPositionState());
      });
    });
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
