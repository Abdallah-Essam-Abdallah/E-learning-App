import 'package:courses_app/features/courses/domain/entity/course_entity.dart';

// ignore: must_be_immutable
class CourseModel extends CourseEntity {
  CourseModel(
      {required super.id,
      required super.title,
      required super.description,
      required super.image,
      required super.time,
      required super.price,
      required super.rating,
      super.isFavorite,
      required super.videos,
      required super.author});

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
        id: json['id'],
        title: json['Title'],
        description: json['Description'],
        image: json['Image'],
        time: json['Time'],
        price: json['Price'],
        rating: json['Rating'],
        author: json['author'],
        videos: const [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'Title': title,
        'Description': description,
        'Image': image,
        'Time': time,
        'Price': price,
        'Rating': rating,
      };
}
