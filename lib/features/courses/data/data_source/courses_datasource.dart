import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:courses_app/core/error/exception.dart';
import 'package:courses_app/features/courses/data/model/course_model.dart';

abstract class CoursesDataSource {
  Future<List<CourseModel>> getTopRatedCourses();
  Future<List<CourseModel>> getCoursesByCategory({required String category});

  Future<List<CourseModel>> getCoursesBySearch({required String searchValue});
}

class CoursesDataSourceImpl extends CoursesDataSource {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<CourseModel>> getCoursesByCategory(
      {required String category}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await firebaseFirestore
          .collection('Courses')
          .where('Category', isEqualTo: category)
          .get();

      List<CourseModel> courses = data.docs
          .map((course) => CourseModel.fromJson(course.data()))
          .toList();
      print(courses);
      return courses;
    } on FirebaseException catch (e) {
      print(e.message);
      throw GetCoursesByCategoryException();
    }
  }

  @override
  Future<List<CourseModel>> getTopRatedCourses() async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await firebaseFirestore
          .collection('Courses')
          .where('Rating', isGreaterThan: 4.5)
          .get();

      List<CourseModel> courses = data.docs
          .map((course) => CourseModel.fromJson(course.data()))
          .toList();
      print(courses);
      return courses;
    } on FirebaseException catch (e) {
      print(e.message);
      throw GetTopRatedCoursesException();
    }
  }

  @override
  Future<List<CourseModel>> getCoursesBySearch(
      {required String searchValue}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await firebaseFirestore
          .collection('Courses')
          .where('Title', isGreaterThanOrEqualTo: searchValue)
          .where('Title', isLessThanOrEqualTo: '$searchValue\uf7ff')
          .get();
      List<CourseModel> courses = data.docs
          .map((course) => CourseModel.fromJson(course.data()))
          .toList();
      print(courses);
      return courses;
    } on FirebaseException catch (e) {
      print(e.message);
      throw GetCoursesBySearchException();
    }
  }
}
