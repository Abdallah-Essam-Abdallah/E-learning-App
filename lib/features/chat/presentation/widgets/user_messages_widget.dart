import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/utils/dateformater.dart';

import 'package:courses_app/features/chat/presentation/widgets/voicemessage_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entity/message_entity.dart';
import '../controller/chat_bloc/chat_bloc.dart';

class UserMessages extends StatelessWidget {
  const UserMessages({super.key, required this.message});

  final MessageEntity message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 34, 56, 180),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (message.messageType == 'text') {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    message.message,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  AutoSizeText(
                    DateFormater.getTime(message),
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.left,
                    minFontSize: 10,
                  ),
                ],
              );
            } else {
              return VoiceMessageWidget(
                message: message,
              );
            }
          },
        ),
      ),
    );
  }
}
