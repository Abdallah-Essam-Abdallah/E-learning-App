import 'package:courses_app/core/error/exception.dart';
import 'package:courses_app/core/error/failure.dart';
import 'package:courses_app/features/chat/data/data_source/chat_datasource.dart';

import 'package:courses_app/features/chat/domain/entity/message_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:record/record.dart';

import '../../../../core/network/internet_connection.dart';
import '../../../../core/utils/appstrings.dart';
import '../../domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatDataSource chatDataSource;
  final InternetConnection internetConnection;

  ChatRepositoryImpl(this.chatDataSource, this.internetConnection);

  @override
  Stream<List<MessageEntity>> getMessage({required String reciverId}) {
    return chatDataSource.getMessage(reciverId: reciverId);
  }

  @override
  Future<Either<Failure, Unit>> sendMessage(
      {required String reciverId,
      required String sendingTime,
      required String text}) async {
    if (await internetConnection.isInternetConnected) {
      try {
        await chatDataSource.sendMessage(
            reciverId: reciverId, sendingTime: sendingTime, text: text);
        return right(unit);
      } on SendMessageException catch (e) {
        return left(SendMessageFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, Unit>> sendVoiceMessage(
      {required String reciverId,
      required String sendingTime,
      required Record record}) async {
    if (await internetConnection.isInternetConnected) {
      try {
        await chatDataSource.sendVoiceMessage(
            reciverId: reciverId, sendingTime: sendingTime, record: record);
        return right(unit);
      } on SendVoiceMessageException catch (e) {
        return left(SendVoiceMessageFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }
}
