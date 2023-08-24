import 'package:equatable/equatable.dart';

class VoiceMessageEntity extends Equatable {
  final String voice;
  final String senderId;
  final String reciverId;
  final String sendingTime;

  const VoiceMessageEntity(
      {required this.voice,
      required this.senderId,
      required this.reciverId,
      required this.sendingTime});

  @override
  List<Object?> get props => [voice, senderId, reciverId, sendingTime];
}
