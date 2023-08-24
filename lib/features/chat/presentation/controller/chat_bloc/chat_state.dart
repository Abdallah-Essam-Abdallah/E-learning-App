part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatInitial extends ChatState {}

class SendMessageLoadingState extends ChatState {}

class SendMessageLoadedState extends ChatState {}

class SendMessageErrorState extends ChatState {
  final String error;

  const SendMessageErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class SendVoiceMessageLoadingState extends ChatState {}

class SendVoiceMessageLoadedState extends ChatState {}

class SendVoiceMessageErrorState extends ChatState {
  final String error;

  const SendVoiceMessageErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class GetMessageLoadingState extends ChatState {}

class GetMessageLoadedState extends ChatState {
  final List<MessageEntity> messages;

  const GetMessageLoadedState({required this.messages});
  @override
  List<Object> get props => [messages];
}

class GetMessageErrorState extends ChatState {
  final String error;

  const GetMessageErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class ChangeRecordingStateSuccesState extends ChatState {}

class ChangeButtonFirstState extends ChatState {}

class ChangeButtonSecondState extends ChatState {}
