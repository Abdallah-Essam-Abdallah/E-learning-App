import 'package:courses_app/core/utils/appstrings.dart';
import 'package:equatable/equatable.dart';

class CategoryData extends Equatable {
  final String title;
  final String image;

  const CategoryData({required this.title, required this.image});

  @override
  List<Object?> get props => [title, image];
}

List<CategoryData> categoryData = [
  const CategoryData(
      title: AppStrings.programing, image: 'assets/images/coding.png'),
  const CategoryData(
      title: AppStrings.design, image: 'assets/images/Gdesign.png'),
  const CategoryData(
      title: AppStrings.language, image: 'assets/images/lang.png'),
];
