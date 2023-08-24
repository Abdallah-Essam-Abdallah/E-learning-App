import '../../domain/entity/voice_message_entity.dart';

class VoiceMessageModel extends VoiceMessageEntity {
  const VoiceMessageModel(
      {required super.voice,
      required super.senderId,
      required super.reciverId,
      required super.sendingTime});

  factory VoiceMessageModel.fromJson(Map<String, dynamic> json) =>
      VoiceMessageModel(
        voice: json['voice'],
        senderId: json['senderId'],
        reciverId: json['reciverId'],
        sendingTime: json['sendingTime'],
      );

  Map<String, dynamic> toJson() => {
        'voice': voice,
        'senderId': senderId,
        'reciverId': reciverId,
        'sendingTime': sendingTime,
      };
}
