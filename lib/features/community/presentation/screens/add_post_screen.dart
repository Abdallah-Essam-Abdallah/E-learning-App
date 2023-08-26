import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/components/snack_bar.dart';
import 'package:courses_app/core/utils/appstrings.dart';
import 'package:courses_app/features/community/presentation/controller/bloc/community_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/responsive.dart';
import '../../../profile/presentation/controller/profile_bloc/profile_bloc.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController textController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(context);
    final CommunityBloc communityBloc = BlocProvider.of<CommunityBloc>(context);
    return BlocProvider.value(
      value: BlocProvider.of<CommunityBloc>(context),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close)),
          actions: [
            BlocConsumer<CommunityBloc, CommunityState>(
              listener: (context, state) {
                if (state is AddPostloadedState) {
                  BlocProvider.of<CommunityBloc>(context).add(GetPostsEvent());
                  Navigator.pop(context);
                } else if (state is AddPostErrorState) {
                  showSnackBar(state.error, context);
                }
              },
              builder: (context, state) {
                return TextButton(
                    onPressed: () {
                      BlocProvider.of<CommunityBloc>(context).add(AddPostEvent(
                          text: textController.text,
                          userName: profileBloc.user!.userName,
                          userImage: profileBloc.user!.image ??
                              AppStrings.profileImage,
                          image: communityBloc.image ?? ''));
                    },
                    child: const AutoSizeText(AppStrings.post));
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextFormField(
                    controller: textController,
                    decoration: const InputDecoration(
                        hintText: AppStrings.shareYourThoughts,
                        border: InputBorder.none),
                    keyboardType: TextInputType.text),
              ),
              BlocConsumer<CommunityBloc, CommunityState>(
                listener: (context, state) {
                  if (state is UploadPostImageErrorState) {
                    showSnackBar(state.error, context);
                  }
                },
                builder: (context, state) {
                  if (state is UploadPostImageLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                  return Center(
                    child: Visibility(
                        visible: state is UploadPostImageLoadedState &&
                            communityBloc.image != null,
                        child: Image(
                          image: NetworkImage(communityBloc.image ?? ''),
                          width: Responsive.getWidth(context),
                          height: Responsive.getHeight(context) * .30,
                          fit: BoxFit.cover,
                        )),
                  );
                },
              ),
              TextButton(
                  onPressed: () {
                    BlocProvider.of<CommunityBloc>(context)
                        .add(UploadPostImageEvent());
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.image),
                      Expanded(child: AutoSizeText(AppStrings.addImage))
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
