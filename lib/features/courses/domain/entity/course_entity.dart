import 'package:courses_app/features/content/domain/entity/video_entity.dart';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class CourseEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String image;
  final String time;
  final int price;
  final double rating;
  final String author;
  bool isFavorite = false;

  List<VideoEntity> videos;

  CourseEntity(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.time,
      required this.price,
      required this.rating,
      required this.author,
      this.isFavorite = false,
      required this.videos});

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        image,
        time,
        price,
        rating,
        isFavorite,
        author,
        videos
      ];
}
