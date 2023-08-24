import 'package:cached_network_image/cached_network_image.dart';
import 'package:courses_app/core/utils/appstrings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/snack_bar.dart';
import '../../../../core/utils/responsive.dart';
import '../controller/profile_bloc/profile_bloc.dart';

class ProfileImageWidget extends StatelessWidget {
  const ProfileImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is UploadProfileImageErrorState) {
          showSnackBar(state.error, context);
        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: () {
            BlocProvider.of<ProfileBloc>(context)
                .add(UploadProfileImageEvent());
          },
          child: state is UploadProfileImageLoadingState
              ? CircleAvatar(
                  radius: Responsive.getWidth(context) * .20,
                  child: const CircularProgressIndicator.adaptive(
                    backgroundColor: Colors.white,
                  ))
              : CircleAvatar(
                  radius: Responsive.getWidth(context) * .20,
                  backgroundImage: CachedNetworkImageProvider(
                      profileBloc.user!.image ?? AppStrings.profileImage),
                ),
        );
      },
    );
  }
}
