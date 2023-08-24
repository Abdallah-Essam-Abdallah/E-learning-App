import 'dart:ui';
import 'package:courses_app/core/utils/responsive.dart';
import 'package:courses_app/features/authentication/presentation/widgets/upperlogincard_widget.dart';
import 'package:flutter/material.dart';
import 'lowerlogincard_widget.dart';

class LoginCardWidget extends StatelessWidget {
  const LoginCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: EdgeInsets.all(Responsive.getWidth(context) * .05),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: Responsive.getHeight(context) * .01,
                  ),
                  const UpperLoginCardWidget(),
                  SizedBox(
                    height: Responsive.getHeight(context) * .05,
                  ),
                  const LowerLoginCardWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
