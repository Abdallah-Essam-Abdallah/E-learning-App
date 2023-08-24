import 'package:courses_app/core/utils/appstrings.dart';
import 'package:equatable/equatable.dart';

class OnBoardingData extends Equatable {
  final String title;
  final String description;
  final String image;

  const OnBoardingData(
      {required this.title, required this.description, required this.image});

  @override
  List<Object?> get props => [title, description, image];
}

List<OnBoardingData> onBoardingData = [
  const OnBoardingData(
      title: AppStrings.onBoardingTitle1,
      description: AppStrings.onBoardingDescription1,
      image: AppStrings.firstOnboardingImage),
  const OnBoardingData(
      title: AppStrings.onBoardingTitle2,
      description: AppStrings.onBoardingDescription2,
      image: AppStrings.secondOnboardingImage),
  const OnBoardingData(
      title: AppStrings.onBoardingTitle3,
      description: AppStrings.onBoardingDescription3,
      image: AppStrings.thirdOnboardingImage),
];
