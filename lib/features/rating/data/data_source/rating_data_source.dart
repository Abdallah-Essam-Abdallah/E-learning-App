import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses_app/core/error/exception.dart';
import 'package:courses_app/features/rating/data/model/rating_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RatingDataSource {
  Future<Unit> addRating(
      {required String comment,
      required double stars,
      required String course,
      required String userName,
      required String userImage});

  Future<List<RatingModel>> getRating({required String course});
}

class RatingDataSourceImpl extends RatingDataSource {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Future<Unit> addRating(
      {required String comment,
      required double stars,
      required String course,
      required String userName,
      required String userImage}) async {
    try {
      RatingModel ratingModel = RatingModel(
          comment: comment,
          userId: userId,
          stars: stars,
          userName: userName,
          userImage: userImage);
      await firebaseFirestore
          .collection('Courses')
          .doc(course)
          .collection('ratings')
          .add(ratingModel.toJson());
      return unit;
    } catch (e) {
      print(e.toString());
      throw AddRatingException();
    }
  }

  @override
  Future<List<RatingModel>> getRating({required String course}) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> ratingResult =
          await firebaseFirestore
              .collection('Courses')
              .doc(course)
              .collection('ratings')
              .get();

      List<RatingModel> ratings = ratingResult.docs
          .map((rating) => RatingModel.fromJson(rating.data()))
          .toList();
      return ratings;
    } catch (e) {
      print(e.toString());
      throw GetRatingException();
    }
  }
}
