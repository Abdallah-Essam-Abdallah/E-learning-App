import 'package:courses_app/features/chat/domain/entity/message_entity.dart';
import 'package:courses_app/features/chat/domain/repository/chat_repository.dart';

class GetMessageUseCase {
  final ChatRepository chatRepository;

  const GetMessageUseCase(this.chatRepository);
  Stream<List<MessageEntity>> call({required String reciverId}) {
    return chatRepository.getMessage(reciverId: reciverId);
  }
}
