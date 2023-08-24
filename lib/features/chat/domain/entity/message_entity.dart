import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String message;
  final String senderId;
  final String reciverId;
  final String sendingTime;
  final String messageType;

  const MessageEntity({
    required this.message,
    required this.senderId,
    required this.reciverId,
    required this.sendingTime,
    required this.messageType,
  });

  @override
  List<Object?> get props =>
      [message, senderId, reciverId, sendingTime, messageType];
}
