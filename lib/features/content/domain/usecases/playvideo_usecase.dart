import 'package:courses_app/features/content/domain/repository/content_repository.dart';

class PlayVideoUseCase {
  final ContentRepository contentRepository;

  const PlayVideoUseCase(this.contentRepository);

  Future<void> call({required String url}) async {
    return await contentRepository.playVideo(url: url);
  }
}
