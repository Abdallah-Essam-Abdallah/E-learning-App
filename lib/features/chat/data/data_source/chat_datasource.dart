import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:courses_app/core/error/exception.dart';
import 'package:courses_app/features/chat/data/model/message_model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:record/record.dart';

abstract class ChatDataSource {
  Future<Unit> sendMessage(
      {required String reciverId,
      required String sendingTime,
      required String text});
  Stream<List<MessageModel>> getMessage({
    required String reciverId,
  });
  Future<Unit> sendVoiceMessage(
      {required String reciverId,
      required String sendingTime,
      required Record record});
}

class ChatDataSourceImpl extends ChatDataSource {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<List<MessageModel>> getMessage({
    required String reciverId,
  }) {
    try {
      return firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(reciverId)
          .collection('messages')
          .orderBy(
            'sendingTime',
          )
          .snapshots()
          .map((snap) => snap.docs
              .map((queryDoc) => MessageModel.fromJson(queryDoc.data()))
              .toList());
    } catch (e) {
      print(e.toString());
      throw GetMessageException();
    }
  }

  @override
  Future<Unit> sendMessage(
      {required String reciverId,
      required String sendingTime,
      required String text}) async {
    try {
      MessageModel messageModel = MessageModel(
          message: text,
          senderId: FirebaseAuth.instance.currentUser!.uid,
          reciverId: reciverId,
          sendingTime: sendingTime,
          messageType: 'text');

      await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(reciverId)
          .collection('messages')
          .add(messageModel.toJson());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(reciverId)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .add(messageModel.toJson());
      return unit;
    } catch (e) {
      print(e.toString());
      throw SendMessageException();
    }
  }

  @override
  Future<Unit> sendVoiceMessage(
      {required String reciverId,
      required String sendingTime,
      required Record record}) async {
    try {
      final data = await record.stop();
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference refrenceDirVoices = referenceRoot.child('voices');
      Reference referenceVoiceToUpload =
          refrenceDirVoices.child(DateTime.now().toString());
      await referenceVoiceToUpload.putFile(File(data!));
      String voiceUrl = await referenceVoiceToUpload.getDownloadURL();
      MessageModel messageModel = MessageModel(
          message: voiceUrl,
          senderId: FirebaseAuth.instance.currentUser!.uid,
          reciverId: reciverId,
          sendingTime: sendingTime,
          messageType: 'audio');
      await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('chats')
          .doc(reciverId)
          .collection('messages')
          .add(messageModel.toJson());

      await FirebaseFirestore.instance
          .collection('users')
          .doc(reciverId)
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .add(messageModel.toJson());
      return unit;
    } catch (e) {
      print(e.toString());
      throw SendVoiceMessageException();
    }
  }
}
