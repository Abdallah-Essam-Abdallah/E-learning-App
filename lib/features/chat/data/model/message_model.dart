import 'package:courses_app/features/chat/domain/entity/message_entity.dart';

class MessageModel extends MessageEntity {
  const MessageModel(
      {required super.message,
      required super.senderId,
      required super.reciverId,
      required super.sendingTime,
      required super.messageType});

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        message: json['message'] ?? '',
        senderId: json['senderId'] ?? '',
        reciverId: json['reciverId'] ?? '',
        sendingTime: json['sendingTime'] ?? '',
        messageType: json['messageType'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'senderId': senderId,
        'reciverId': reciverId,
        'sendingTime': sendingTime,
        'messageType': messageType,
      };
}
