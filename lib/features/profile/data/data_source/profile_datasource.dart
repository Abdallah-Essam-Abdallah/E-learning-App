import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/error/exception.dart';
import '../../../authentication/data/model/user_model.dart';

abstract class ProfileDataSource {
  Future<String> uploadProfileImage();
  Future<UserModel> getUserData();
  Future<void> signOut();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Future<String> uploadProfileImage() async {
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
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({'image': imageUrl}, SetOptions(merge: true));

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
  Future<UserModel> getUserData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get();
      UserModel model = UserModel.fromJson(userData.data()!);
      return model;
    } on FirebaseException catch (e) {
      print(e);
      throw GetUserDataException();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      throw UnexpectedException();
    }
  }
}
