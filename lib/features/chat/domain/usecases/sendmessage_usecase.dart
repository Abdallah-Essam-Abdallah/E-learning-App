import 'package:courses_app/features/chat/domain/repository/chat_repository.dart';

import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

class SendMessageUseCase {
  final ChatRepository chatRepository;

  const SendMessageUseCase(this.chatRepository);
  Future<Either<Failure, Unit>> call(
      {required String reciverId,
      required String sendingTime,
      required String text}) async {
    return await chatRepository.sendMessage(
        reciverId: reciverId, sendingTime: sendingTime, text: text);
  }
}
