import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/appstrings.dart';
import '../../../../core/utils/responsive.dart';

class NoBookedCoursesWidget extends StatelessWidget {
  const NoBookedCoursesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lotties/emptyCart1.json',
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: Responsive.getHeight(context) * .03,
          ),
          AutoSizeText(
            AppStrings.noBookedCourses,
            style: Theme.of(context).textTheme.headlineMedium,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
