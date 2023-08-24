import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/appstrings.dart';
import '../../../../core/utils/responsive.dart';

class NoRatingWidget extends StatelessWidget {
  const NoRatingWidget({super.key, required this.course});
  final String course;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lotties/ratings.json',
            fit: BoxFit.cover,
            height: Responsive.getHeight(context) * .30,
          ),
          SizedBox(
            height: Responsive.getHeight(context) * .01,
          ),
          SizedBox(
            height: Responsive.getHeight(context) * .10,
            width: Responsive.getWidth(context),
            child: AutoSizeText(
              AppStrings.noRatings,
              style: Theme.of(context).textTheme.headlineMedium,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Responsive.getHeight(context) * .02,
          )
        ],
      ),
    );
  }
}
