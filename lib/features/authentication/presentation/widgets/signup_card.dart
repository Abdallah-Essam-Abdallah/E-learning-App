import 'dart:ui';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/utils/appstrings.dart';
import 'package:courses_app/features/authentication/presentation/widgets/signupcardtextfields.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';

class SignUpCard extends StatelessWidget {
  const SignUpCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(83, 255, 255, 255),
          ),
          height: Responsive.getHeight(context) * .85,
          width: Responsive.getWidth(context) * .90,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                  child: Padding(
                      padding:
                          EdgeInsets.all(Responsive.getWidth(context) * .05),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(children: [
                          SizedBox(
                            height: Responsive.getHeight(context) * .01,
                          ),
                          SizedBox(
                            width: Responsive.getWidth(context) * .50,
                            child: AutoSizeText(
                              AppStrings.signUp,
                              style: Theme.of(context).textTheme.headlineMedium,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: Responsive.getHeight(context) * .01,
                          ),
                          SizedBox(
                            width: Responsive.getWidth(context) * .80,
                            child: AutoSizeText(
                              AppStrings.signupDescription,
                              style: Theme.of(context).textTheme.titleLarge,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: Responsive.getHeight(context) * .03,
                          ),
                          const SignupCardTextFields(),
                        ]),
                      ))))),
    );
  }
}
