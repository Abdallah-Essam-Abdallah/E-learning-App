import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses_app/core/error/exception.dart';
import 'package:courses_app/features/content/data/model/content_model.dart';
import 'package:courses_app/features/courses/data/model/course_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

abstract class ContentDataSource {
  Future<List<CourseModel>> getBookedCourses();
}

class ContentDataSourceImpl extends ContentDataSource {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Future<List<CourseModel>> getBookedCourses() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> data = await firebaseFirestore
          .collection('Courses')
          .where('purchasedBy', arrayContains: userId)
          .get();

      final List<CourseModel> models = data.docs
          .map((course) => CourseModel.fromJson(course.data()))
          .toList();

      await Future.forEach(models, (CourseModel courseModel) async {
        QuerySnapshot<Map<String, dynamic>> videosdata = await firebaseFirestore
            .collection('Courses')
            .doc(courseModel.title)
            .collection('content')
            .get();
        List<VideoModel> videos = videosdata.docs
            .map((video) => VideoModel.fromJson(video.data()))
            .toList();
        courseModel.videos = videos;
        print(courseModel.toString());
      });

      print(models);
      return models;
    } catch (e) {
      print(e.toString());
      throw GetBookedCoursesException();
    }
  }
}
