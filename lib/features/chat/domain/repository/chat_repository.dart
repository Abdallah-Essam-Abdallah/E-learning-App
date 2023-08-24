import 'package:courses_app/core/error/failure.dart';
import 'package:courses_app/features/chat/domain/entity/message_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:record/record.dart';

abstract class ChatRepository {
  Future<Either<Failure, Unit>> sendMessage(
      {required String reciverId,
      required String sendingTime,
      required String text});
  Stream<List<MessageEntity>> getMessage({required String reciverId});
  Future<Either<Failure, Unit>> sendVoiceMessage(
      {required String reciverId,
      required String sendingTime,
      required Record record});
}
