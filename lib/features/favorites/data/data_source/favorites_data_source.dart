import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:courses_app/core/error/exception.dart';
import 'package:courses_app/features/courses/data/model/course_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../courses/domain/entity/course_entity.dart';

abstract class FavoritesDataSource {
  Future<Unit> addCourseToFavorites({required CourseEntity favoriteCourse});

  Future<List<CourseModel>> getFavoriteCourses();
}

class FavoritesDataSourceImpl extends FavoritesDataSource {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Future<Unit> addCourseToFavorites(
      {required CourseEntity favoriteCourse}) async {
    try {
      if (favoriteCourse.isFavorite) {
        favoriteCourse.isFavorite = true;
        await firebaseFirestore.collection('users').doc(userId).update({
          'favorites': FieldValue.arrayUnion([favoriteCourse.title])
        });
      } else {
        favoriteCourse.isFavorite = false;
        await firebaseFirestore.collection('users').doc(userId).update({
          'favorites': FieldValue.arrayRemove([favoriteCourse.title])
        });
      }
      return unit;
    } catch (e) {
      print(e.toString());
      throw AddCourseToFavoriteException();
    }
  }

  @override
  Future<List<CourseModel>> getFavoriteCourses() async {
    try {
      final doc = await firebaseFirestore.collection('users').doc(userId).get();
      final favorites = List<String>.from(doc.data()!['favorites']);

      QuerySnapshot<Map<String, dynamic>> data = await firebaseFirestore
          .collection('Courses')
          .where('Title', whereIn: favorites)
          .get();
      List<CourseModel> courses = data.docs
          .map((course) => CourseModel.fromJson(course.data()))
          .toList();

      return courses;
    } catch (e) {
      print(e.toString());
      throw GetFavoriteCoursesException();
    }
  }
}
