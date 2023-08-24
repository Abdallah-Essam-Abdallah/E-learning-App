import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/chache_helper/chache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/appstrings.dart';
import '../../../../core/utils/responsive.dart';
import '../controller/authentication_bloc/authentication_bloc.dart';
import '../screens/signup_screen.dart';

class LowerLoginCardWidget extends StatelessWidget {
  const LowerLoginCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Divider(
                thickness: 2,
              ),
            ),
            Expanded(
                child: AutoSizeText(
              AppStrings.orLogInWith,
              maxLines: 1,
            )),
            Expanded(
              child: Divider(
                thickness: 2,
              ),
            ),
          ],
        ),
        SizedBox(
          height: Responsive.getHeight(context) * .05,
        ),
        Center(
          child: Column(
            children: [
              SizedBox(
                width: Responsive.getWidth(context) * .50,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color?>(Colors.white)),
                    onPressed: () {
                      BlocProvider.of<AuthenticationBloc>(context)
                          .add(SignInWithGoogleEvent());
                      CacheHelper.setBoolean(key: 'isLoggedIn', value: true);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.red,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: AutoSizeText(
                            AppStrings.loginWithGoogle,
                            style: TextStyle(color: Colors.black),
                            maxLines: 1,
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                width: Responsive.getWidth(context) * .50,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color?>(
                            const Color.fromARGB(255, 21, 118, 197))),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: AutoSizeText(
                            AppStrings.loginWithFacebook,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: Responsive.getHeight(context) * .05,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const AutoSizeText(
              AppStrings.dontHaveAnAccount,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            TextButton(
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const SignUpScreen()))),
                child: const AutoSizeText(
                  AppStrings.signUp,
                  maxLines: 1,
                ))
          ],
        ),
      ],
    );
  }
}
