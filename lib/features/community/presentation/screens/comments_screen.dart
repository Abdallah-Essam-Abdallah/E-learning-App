import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/components/snack_bar.dart';
import 'package:courses_app/core/components/text_form_field.dart';
import 'package:courses_app/core/utils/appstrings.dart';
import 'package:courses_app/features/community/presentation/controller/bloc/community_bloc.dart';
import 'package:courses_app/features/community/presentation/widgets/comment_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/responsive.dart';
import '../../../profile/presentation/controller/profile_bloc/profile_bloc.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({
    super.key,
    required this.postId,
  });

  final String postId;

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(context);
    return BlocProvider.value(
      value: BlocProvider.of<CommunityBloc>(context)
        ..add(GetCommentsEvent(postId: widget.postId)),
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(AppStrings.comments),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Responsive.getWidth(context) * .05,
              horizontal: Responsive.getWidth(context) * .02),
          child: Column(
            children: [
              BlocBuilder<CommunityBloc, CommunityState>(
                buildWhen: (previous, current) {
                  return previous is GetCommentsloadingState ||
                      current is GetCommentsloadedState;
                },
                builder: (context, state) {
                  if (state is GetCommentsloadingState) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is GetCommentsloadedState) {
                    return Expanded(
                      child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final comment = state.comments[index];
                            return CommentItem(comment: comment);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: Responsive.getHeight(context) * .03,
                            );
                          },
                          itemCount: state.comments.length),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: AppTextFormField(
                        controller: commentController,
                        hintText: AppStrings.writeComment,
                        obscureText: false,
                        keyboardType: TextInputType.text),
                  ),
                  BlocListener<CommunityBloc, CommunityState>(
                    listener: (context, state) {
                      if (state is AddCommentErrorState) {
                        showSnackBar(state.error, context);
                      }
                    },
                    child: IconButton(
                        onPressed: () {
                          if (commentController.text == '') {
                            () {};
                          } else {
                            BlocProvider.of<CommunityBloc>(context)
                                .add(AddCommentEvent(
                              text: commentController.text,
                              commentingTime: DateTime.now().toString(),
                              userImage: profileBloc.user!.image ??
                                  AppStrings.profileImage,
                              userName: profileBloc.user!.userName,
                              userId: profileBloc.user!.userId,
                              postId: widget.postId,
                            ));
                            commentController.clear();
                          }
                        },
                        icon: const Icon(Icons.add_comment)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
