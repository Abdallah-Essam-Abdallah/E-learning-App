import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/features/content/presentation/screens/purchased_courses_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/chache_helper/chache_helper.dart';
import '../../../../core/components/snack_bar.dart';
import '../../../../core/utils/appstrings.dart';
import '../../../../core/utils/responsive.dart';
import '../../../authentication/presentation/screens/login_screen.dart';
import '../../../favorites/presentation/favorites_bloc/favorites_bloc.dart';
import '../../../favorites/presentation/screen/favorites_screen.dart';
import '../controller/profile_bloc/profile_bloc.dart';

class ProfileScreenList extends StatelessWidget {
  const ProfileScreenList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 15,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            const PurchasedCoursesScreen())));
              },
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              leading: const Icon(
                Icons.shopping_cart,
                color: Colors.indigo,
              ),
              title: const AutoSizeText(AppStrings.myCourses),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.indigo,
              ),
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .01,
            ),
            ListTile(
              tileColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              leading: const Icon(
                Icons.favorite,
                color: Colors.indigo,
              ),
              title: const AutoSizeText(AppStrings.myFavorites),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.indigo,
              ),
              onTap: () {
                BlocProvider.of<FavoritesBloc>(context)
                    .add(const GetFavoriteCoursesEvent());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const FavoritesScreen())));
              },
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .01,
            ),
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state is SignoutLoadingState) {
                  const CircularProgressIndicator.adaptive();
                } else if (state is SignoutErrorState) {
                  showSnackBar(state.error, context);
                }
              },
              child: ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: const AutoSizeText(
                  AppStrings.signOut,
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  CacheHelper.setBoolean(key: 'isLoggedIn', value: false);

                  CacheHelper.remove(key: 'userName');
                  BlocProvider.of<ProfileBloc>(context).add(SignOutEvent());

                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const LogInScreen())),
                      (route) => false);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
