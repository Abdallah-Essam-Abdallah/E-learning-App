part of 'audio_bloc.dart';

class AudioState extends Equatable {
  const AudioState();

  @override
  List<Object> get props => [];
}

class AudioInitial extends AudioState {}

class AudioPlayingIntialState extends AudioState {}

class AudioPlayingState extends AudioState {}

class UpdateAudioDurationState extends AudioState {}

class UpdateAudioDurationIntialState extends AudioState {}

class UpdateAudioPositionState extends AudioState {}

class UpdateAudioPositionIntialState extends AudioState {}
