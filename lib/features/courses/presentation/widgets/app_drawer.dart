import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:courses_app/core/utils/appstrings.dart';
import 'package:courses_app/core/utils/responsive.dart';

import 'package:courses_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:courses_app/features/community/presentation/screens/community_screen.dart';

import 'package:courses_app/features/content/presentation/screens/purchased_courses_screen.dart';

import 'package:courses_app/features/favorites/presentation/favorites_bloc/favorites_bloc.dart';
import 'package:courses_app/features/favorites/presentation/screen/favorites_screen.dart';
import 'package:courses_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../profile/presentation/controller/profile_bloc/profile_bloc.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final profileBloc = BlocProvider.of<ProfileBloc>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: Responsive.getHeight(context) * .30,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: Responsive.getWidth(context) * .12,
                    backgroundImage: CachedNetworkImageProvider(
                        profileBloc.user!.image ?? AppStrings.profileImage),
                  ),
                  SizedBox(
                    height: Responsive.getHeight(context) * .01,
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
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: Colors.indigo,
            ),
            title: const Text(AppStrings.home),
            onTap: () {
              Navigator.pop(context);
              BlocProvider.of<FavoritesBloc>(context)
                  .add(const GetFavoriteCoursesEvent());
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.account_circle,
              color: Colors.indigo,
            ),
            title: const Text(AppStrings.profile),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const ProfileScreen())));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.favorite,
              color: Colors.indigo,
            ),
            title: const Text(AppStrings.favorites),
            onTap: () {
              BlocProvider.of<FavoritesBloc>(context)
                  .add(const GetFavoriteCoursesEvent());
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const FavoritesScreen())));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.fit_screen,
              color: Colors.indigo,
            ),
            title: const Text(AppStrings.myCourses),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const PurchasedCoursesScreen())));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.group,
              color: Colors.indigo,
            ),
            title: const Text(AppStrings.community),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const CommunityScreen())));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.contact_support,
              color: Colors.indigo,
            ),
            title: const Text(AppStrings.contactUs),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const ChatScreen(
                            adminId: '01',
                          ))));
            },
          ),
        ],
      ),
    );
  }
}
