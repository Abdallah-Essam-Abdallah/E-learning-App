import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:courses_app/features/chat/domain/usecases/getmessage_usecase.dart';
import 'package:courses_app/features/chat/domain/usecases/sendmessage_usecase.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/services.dart';
import 'package:record/record.dart';
import '../../../domain/entity/message_entity.dart';

import '../../../domain/usecases/sendvoicemessage_usecase.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetMessageUseCase getMessageUseCase;
  final SendVoiceMessageUseCase sendVoiceMessageUseCase;

  bool isRecording = false;
  bool isRecordingButton = false;

  ChatBloc({
    required this.sendMessageUseCase,
    required this.getMessageUseCase,
    required this.sendVoiceMessageUseCase,
  }) : super(ChatInitial()) {
    on<SendMessageEvent>((event, emit) async {
      final response = await sendMessageUseCase.call(
          reciverId: event.reciverId,
          sendingTime: event.sendingTime,
          text: event.text);
      response.fold(
          (faliure) => emit(SendMessageErrorState(error: faliure.message)),
          (success) => SendMessageLoadedState());
    });

    on<SendVoiceMessageEvent>((event, emit) async {
      final response = await sendVoiceMessageUseCase.call(
          reciverId: event.reciverId,
          sendingTime: event.sendingTime,
          record: event.record);
      response.fold(
          (faliure) => emit(SendVoiceMessageErrorState(error: faliure.message)),
          (success) => SendVoiceMessageLoadedState());
    });

    on<GetMessageEvent>((event, emit) async {
      emit(GetMessageLoadingState());
      final response = getMessageUseCase.call(
        reciverId: event.reciverId,
      );
      await for (final messages in response) {
        emit(GetMessageLoadedState(messages: messages));
      }
    });

    on<ChangeRecordingStateEvent>((event, emit) {
      isRecording = !isRecording;
      emit(ChangeRecordingStateSuccesState());
    });

    on<ChangeButtonEvent>((event, emit) {
      if (event.value == '') {
        isRecordingButton = !isRecordingButton;
        emit(ChangeButtonFirstState());
      } else {
        isRecordingButton = false;
        emit(ChangeButtonSecondState());
      }
    });

    on<PlayMessageSoundEvent>((event, emit) async {
      String audioasset = event.asset;
      ByteData bytes = await rootBundle.load(audioasset);
      Uint8List soundbytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      AudioPlayer().play(BytesSource(soundbytes));
    });
  }
}
