import 'package:auto_size_text/auto_size_text.dart';

import 'package:courses_app/core/utils/appstrings.dart';
import 'package:courses_app/core/utils/responsive.dart';

import 'package:courses_app/features/profile/presentation/controller/profile_bloc/profile_bloc.dart';
import 'package:courses_app/features/profile/presentation/widgets/profile_screen_list.dart';
import 'package:courses_app/features/profile/presentation/widgets/profileimage_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    return BlocProvider.value(
      value: BlocProvider.of<ProfileBloc>(context),
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(AppStrings.profile),
        ),
        body: Padding(
          padding: EdgeInsets.all(Responsive.getHeight(context) * .02),
          child: Center(
            child: Column(
              children: [
                const ProfileImageWidget(),
                SizedBox(
                  height: Responsive.getHeight(context) * .02,
                ),
                Expanded(
                  child: AutoSizeText(
                    profileBloc.user!.userName ??
                        FirebaseAuth.instance.currentUser!.displayName!,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: Responsive.getHeight(context) * .01,
                ),
                Expanded(
                  child: AutoSizeText(
                    profileBloc.user!.email ??
                        FirebaseAuth.instance.currentUser!.email!,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                  ),
                ),
                SizedBox(
                  height: Responsive.getHeight(context) * .05,
                ),
                const ProfileScreenList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
