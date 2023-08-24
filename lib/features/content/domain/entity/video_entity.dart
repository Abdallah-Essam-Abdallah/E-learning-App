import 'package:equatable/equatable.dart';

class VideoEntity extends Equatable {
  final String url;
  final String name;
  final String thumbnail;

  const VideoEntity(
      {required this.url, required this.name, required this.thumbnail});

  @override
  List<Object?> get props => [url, name, thumbnail];
}
