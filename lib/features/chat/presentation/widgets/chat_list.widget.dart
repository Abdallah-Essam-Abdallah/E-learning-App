import 'dart:async';

import 'package:courses_app/features/chat/domain/entity/message_entity.dart';
import 'package:courses_app/features/chat/presentation/widgets/user_messages_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../../core/utils/responsive.dart';
import 'admin_messages_widget.dart';

class ChatListWidget extends StatelessWidget {
  const ChatListWidget(
      {super.key, required this.messages, required this.scrollController});
  final List<MessageEntity> messages;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.getWidth(context) * .03),
      child: ListView.separated(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            Timer timer = Timer(const Duration(milliseconds: 100), () {
              if (scrollController.hasClients) {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastEaseInToSlowEaseOut,
                );
              }
            });
            scrollController.addListener(() {
              if (scrollController.position.userScrollDirection ==
                      ScrollDirection.forward ||
                  scrollController.position.userScrollDirection ==
                      ScrollDirection.reverse) {
                timer.cancel();
              }
            });

            final message = messages[index];
            if (FirebaseAuth.instance.currentUser!.uid == message.senderId) {
              return UserMessages(
                message: message,
              );
            }

            return AdminMessages(
              message: message,
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: Responsive.getHeight(context) * .02);
          },
          itemCount: messages.length),
    );
  }
}
