import 'package:courses_app/core/error/exception.dart';
import 'package:courses_app/core/error/failure.dart';
import 'package:courses_app/features/content/data/data_source/content_datasource.dart';
import 'package:courses_app/features/courses/domain/entity/course_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:video_player/video_player.dart';

import '../../../../core/network/internet_connection.dart';
import '../../../../core/utils/appstrings.dart';
import '../../domain/repository/content_repository.dart';

class ContentRepositoryImpl extends ContentRepository {
  final ContentDataSource contentDataSource;
  final InternetConnection internetConnection;

  ContentRepositoryImpl(this.contentDataSource, this.internetConnection);

  @override
  Future<void> playVideo({required String url}) async {
    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    await controller.initialize();
    await controller.play();
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getBookedCourses() async {
    if (await internetConnection.isInternetConnected) {
      try {
        final result = await contentDataSource.getBookedCourses();
        return right(result);
      } on GetBookedCoursesException catch (e) {
        return left(GetBookedCoursesFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }
}
