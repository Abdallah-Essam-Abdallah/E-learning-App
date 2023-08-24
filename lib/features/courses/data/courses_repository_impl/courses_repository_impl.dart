import 'package:courses_app/core/error/exception.dart';
import 'package:courses_app/core/error/failure.dart';
import 'package:courses_app/features/courses/data/data_source/courses_datasource.dart';

import 'package:courses_app/features/courses/domain/repository/courses_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/internet_connection.dart';
import '../../../../core/utils/appstrings.dart';
import '../../domain/entity/course_entity.dart';

class CoursesRepositoryImpl extends CoursesRepository {
  final CoursesDataSource coursesDataSource;
  final InternetConnection internetConnection;

  CoursesRepositoryImpl(this.coursesDataSource, this.internetConnection);

  @override
  Future<Either<Failure, List<CourseEntity>>> getCoursesByCategory(
      {required String category}) async {
    if (await internetConnection.isInternetConnected) {
      try {
        final result =
            await coursesDataSource.getCoursesByCategory(category: category);
        return right(result);
      } on GetCoursesByCategoryException catch (e) {
        return left(GetCoursesByCategoryFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getTopRatedCourses() async {
    if (await internetConnection.isInternetConnected) {
      try {
        final result = await coursesDataSource.getTopRatedCourses();
        return right(result);
      } on GetTopRatedCoursesException catch (e) {
        return left(GetTopRatedCoursesFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getCoursesBySearch(
      {required String searchValue}) async {
    if (await internetConnection.isInternetConnected) {
      try {
        final result = await coursesDataSource.getCoursesBySearch(
            searchValue: searchValue);
        return right(result);
      } on GetCoursesBySearchException catch (e) {
        return left(GetCoursesBySearchFaliure(e.message));
      }
    } else {
      return left(const NoInternetFailure(AppStrings.internetFaliureMessage));
    }
  }
}
