import 'package:courses_app/core/utils/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record/record.dart';
import '../../../../core/utils/responsive.dart';
import '../controller/chat_bloc/chat_bloc.dart';

class VoiceMessageButton extends StatelessWidget {
  const VoiceMessageButton(
      {super.key, required this.record, required this.adminId});
  final Record record;
  final String adminId;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return GestureDetector(
          child: CircleAvatar(
            radius: !BlocProvider.of<ChatBloc>(context).isRecording
                ? Responsive.getWidth(context) * .05
                : Responsive.getWidth(context) * .09,
            child: Icon(
              Icons.mic,
              size: !BlocProvider.of<ChatBloc>(context).isRecording
                  ? Responsive.getWidth(context) * .06
                  : Responsive.getWidth(context) * .10,
            ),
          ),
          onLongPress: () async {
            BlocProvider.of<ChatBloc>(context).add(const PlayMessageSoundEvent(
                asset: AppStrings.recordStartSound));
            BlocProvider.of<ChatBloc>(context).add(ChangeRecordingStateEvent());

            bool hasVoicePermission = await record.hasPermission();
            if (hasVoicePermission) {
              record.start();
            }
          },
          onLongPressEnd: (details) {
            BlocProvider.of<ChatBloc>(context).add(ChangeRecordingStateEvent());
            BlocProvider.of<ChatBloc>(context).add(SendVoiceMessageEvent(
                reciverId: adminId,
                sendingTime: DateTime.now().toString(),
                record: record));
            BlocProvider.of<ChatBloc>(context).add(
                const PlayMessageSoundEvent(asset: AppStrings.recordEndSound));
          },
        );
      },
    );
  }
}
