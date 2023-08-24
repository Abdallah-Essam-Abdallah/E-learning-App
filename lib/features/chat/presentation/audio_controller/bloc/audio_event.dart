part of 'audio_bloc.dart';

class AudioEvent extends Equatable {
  const AudioEvent();

  @override
  List<Object> get props => [];
}

class UpdateDurationEvent extends AudioEvent {}

class UpdatePositionEvent extends AudioEvent {}

class AudioPlayingEvent extends AudioEvent {
  final String audioUrl;

  const AudioPlayingEvent({required this.audioUrl});
  @override
  List<Object> get props => [audioUrl];
}
