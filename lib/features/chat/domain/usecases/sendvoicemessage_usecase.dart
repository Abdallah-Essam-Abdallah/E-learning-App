import 'package:courses_app/features/chat/domain/repository/chat_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:record/record.dart';

import '../../../../core/error/failure.dart';

class SendVoiceMessageUseCase {
  final ChatRepository chatRepository;

  const SendVoiceMessageUseCase(this.chatRepository);
  Future<Either<Failure, Unit>> call(
      {required String reciverId,
      required String sendingTime,
      required Record record}) async {
    return await chatRepository.sendVoiceMessage(
        reciverId: reciverId, sendingTime: sendingTime, record: record);
  }
}
