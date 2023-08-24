part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatEvent {
  final String reciverId;
  final String sendingTime;
  final String text;

  const SendMessageEvent(
      {required this.reciverId, required this.sendingTime, required this.text});
  @override
  List<Object> get props => [reciverId, sendingTime, text];
}

class SendVoiceMessageEvent extends ChatEvent {
  final String reciverId;
  final String sendingTime;

  final Record record;

  const SendVoiceMessageEvent({
    required this.reciverId,
    required this.sendingTime,
    required this.record,
  });
  @override
  List<Object> get props => [
        reciverId,
        sendingTime,
      ];
}

class GetMessageEvent extends ChatEvent {
  final String reciverId;

  const GetMessageEvent({required this.reciverId});
  @override
  List<Object> get props => [reciverId];
}

class GetVoiceMessageEvent extends ChatEvent {
  final String reciverId;

  const GetVoiceMessageEvent({required this.reciverId});
  @override
  List<Object> get props => [reciverId];
}

class ChangeRecordingStateEvent extends ChatEvent {}

class ChangeButtonEvent extends ChatEvent {
  final String value;

  const ChangeButtonEvent({required this.value});

  @override
  List<Object> get props => [value];
}

class PlayMessageSoundEvent extends ChatEvent {
  final String asset;

  const PlayMessageSoundEvent({required this.asset});
  @override
  List<Object> get props => [asset];
}




/*class FormateDateEvent extends ChatEvent {
  final MessageEntity messageEntity;

  const FormateDateEvent({required this.messageEntity});
  @override
  List<Object> get props => [messageEntity];
}*/
