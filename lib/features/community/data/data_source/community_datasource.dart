import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses_app/core/error/exception.dart';
import 'package:courses_app/features/community/data/model/comment_model.dart';
import 'package:courses_app/features/community/data/model/post_model.dart';
import 'package:courses_app/features/community/domain/entity/post_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

abstract class CommunityDataSource {
  Future<Unit> addPost(
      {required String text,
      String? image,
      required String userName,
      required String userImage});
  Future<String> uploadPostImage();
  Stream<List<PostModel>> getPosts();
  Future<Unit> addLike({required PostEntity post});
  Future<Unit> addComment(
      {required String postId,
      required String userId,
      required String text,
      required String commentingTime,
      required String userName,
      required String userImage});
  Stream<List<CommentModel>> getComments({required String postId});
}

class CommunityDataSourceImpl extends CommunityDataSource {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  final String postPublishTime = DateTime.now().toString();
  @override
  Future<Unit> addComment(
      {required String postId,
      required String userId,
      required String text,
      required String commentingTime,
      required String userName,
      required String userImage}) async {
    try {
      CommentModel commentModel = CommentModel(
          text: text,
          userId: userId,
          postId: postId,
          commentingTime: commentingTime,
          userName: userName,
          userImage: userImage);
      await firebaseFirestore
          .collection('Posts')
          .doc(postId)
          .collection('comments')
          .add(commentModel.toJson());

      await FirebaseFirestore.instance
          .collection('Posts')
          .doc(postId)
          .update({'comments': FieldValue.increment(1)});

      return unit;
    } catch (e) {
      print(e.toString());
      throw AddCommentException();
    }
  }

  @override
  Future<Unit> addLike({required PostEntity post}) async {
    try {
      if (!post.likes.contains(userId)) {
        await firebaseFirestore.collection('Posts').doc(post.postId).update({
          'likes': FieldValue.arrayUnion([userId])
        });
      } else {
        await firebaseFirestore.collection('Posts').doc(post.postId).update({
          'likes': FieldValue.arrayRemove([userId])
        });
      }

      return unit;
    } catch (e) {
      print(e.toString());
      throw AddLikeException();
    }
  }

  @override
  Future<Unit> addPost(
      {required String text,
      String? image,
      required String userName,
      required String userImage}) async {
    try {
      PostModel postModel = PostModel(
          userImage: userImage,
          text: text,
          postingTime: postPublishTime,
          likes: const [],
          comments: 0,
          userId: userId,
          userName: userName,
          image: image ?? '',
          postId: userId + postPublishTime);

      await firebaseFirestore
          .collection('Posts')
          .doc(userId + postPublishTime)
          .set(postModel.toJson());
      return unit;
    } catch (e) {
      print(e.toString());
      throw AddPostException();
    }
  }

  @override
  Future<String> uploadPostImage() async {
    try {
      ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

      try {
        if (file == null) {
          throw NoImageChoosedException();
        }
      } catch (e) {
        print(e.toString());
        throw NoImageChoosedException();
      }

      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference refrenceDirImages = referenceRoot.child('images');
      Reference referenceImageToUpload = refrenceDirImages.child(file.name);
      await referenceImageToUpload.putFile(File(file.path));
      String imageUrl = await referenceImageToUpload.getDownloadURL();

      print(file.path);
      return imageUrl;
    } on NoImageChoosedException catch (e) {
      print(e);
      throw NoImageChoosedException();
    } catch (e) {
      print(e);
      throw ImageUplodedException();
    }
  }

  @override
  Stream<List<PostModel>> getPosts() {
    try {
      return firebaseFirestore
          .collection('Posts')
          .orderBy('postingTime')
          .snapshots()
          .map((snap) => snap.docs
              .map((queryDoc) => PostModel.fromJson(queryDoc.data()))
              .toList());
    } catch (e) {
      print(e.toString());
      throw GetPostsException();
    }
  }

  @override
  Stream<List<CommentModel>> getComments({required String postId}) {
    try {
      return firebaseFirestore
          .collection('Posts')
          .doc(postId)
          .collection('comments')
          .orderBy('commentingTime')
          .snapshots()
          .map((snap) => snap.docs
              .map((queryDoc) => CommentModel.fromJson(queryDoc.data()))
              .toList());
    } catch (e) {
      print(e.toString());
      throw GetMessageException();
    }
  }
}
