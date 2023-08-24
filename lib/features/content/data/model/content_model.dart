import '../../domain/entity/video_entity.dart';

class VideoModel extends VideoEntity {
  const VideoModel({
    required super.url,
    required super.name,
    required super.thumbnail,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) => VideoModel(
        url: json['url'],
        name: json['name'],
        thumbnail: json['thumbnail'],
      );
}
