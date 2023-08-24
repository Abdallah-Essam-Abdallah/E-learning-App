import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/components/snack_bar.dart';
import 'package:courses_app/core/components/text_form_field.dart';
import 'package:courses_app/core/utils/appstrings.dart';
import 'package:courses_app/core/utils/responsive.dart';
import 'package:courses_app/features/chat/presentation/widgets/chat_list.widget.dart';
import 'package:courses_app/features/chat/presentation/widgets/voicemessagebutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record/record.dart';
import '../controller/chat_bloc/chat_bloc.dart';
import '/core/dependency_injection/injection.dart' as di;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.adminId});
  final String adminId;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController messageController = TextEditingController();
  final Record record = Record();

  @override
  void dispose() {
    scrollController.dispose();
    messageController.dispose();
    record.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          di.getIt<ChatBloc>()..add(GetMessageEvent(reciverId: widget.adminId)),
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(AppStrings.chat),
        ),
        body: Padding(
          padding: EdgeInsets.all(Responsive.getWidth(context) * .03),
          child: Column(
            children: [
              Expanded(
                  child: BlocConsumer<ChatBloc, ChatState>(
                buildWhen: (previous, current) {
                  return previous is GetMessageLoadingState ||
                      current is GetMessageLoadedState;
                },
                listener: (context, state) {
                  if (state is SendMessageErrorState) {
                    showSnackBar(state.error, context);
                  } else if (state is SendVoiceMessageErrorState) {
                    showSnackBar(state.error, context);
                  }
                },
                builder: (context, state) {
                  if (state is GetMessageLoadingState) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (state is GetMessageLoadedState) {
                    if (state.messages.isEmpty) {
                      return const SizedBox();
                    }
                    return ChatListWidget(
                        messages: state.messages,
                        scrollController: scrollController);
                  } else {
                    return const SizedBox();
                  }
                },
              )),
              Row(children: [
                Expanded(
                  flex: 2,
                  child: BlocBuilder<ChatBloc, ChatState>(
                    builder: (context, state) {
                      return AppTextFormField(
                        controller: messageController,
                        hintText: BlocProvider.of<ChatBloc>(context).isRecording
                            ? AppStrings.recording
                            : AppStrings.typeYourMessage,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          BlocProvider.of<ChatBloc>(context)
                              .add(ChangeButtonEvent(value: value));
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: Responsive.getWidth(context) * .01,
                ),
                BlocBuilder<ChatBloc, ChatState>(
                  builder: (context, state) {
                    if (!BlocProvider.of<ChatBloc>(context).isRecordingButton &&
                        messageController.value.text.isNotEmpty) {
                      return CircleAvatar(
                        radius: Responsive.getWidth(context) * .05,
                        child: IconButton(
                            onPressed: () {
                              messageController.text == ''
                                  ? () {}
                                  : BlocProvider.of<ChatBloc>(context).add(
                                      SendMessageEvent(
                                          reciverId: widget.adminId,
                                          sendingTime:
                                              DateTime.now().toString(),
                                          text: messageController.text));

                              messageController.clear();
                            },
                            icon: const Icon(Icons.send)),
                      );
                    } else {
                      return VoiceMessageButton(
                        record: record,
                        adminId: widget.adminId,
                      );
                    }
                  },
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
