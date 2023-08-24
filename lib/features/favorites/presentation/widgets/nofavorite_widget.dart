import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/utils/appstrings.dart';
import '../../../../core/utils/responsive.dart';

class NoFavoriteCoursesWidget extends StatelessWidget {
  const NoFavoriteCoursesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(Responsive.getWidth(context) * .01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Responsive.getHeight(context) * .05,
          ),
          Lottie.asset(
            'assets/lotties/favorites.json',
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: Responsive.getHeight(context) * .03,
          ),
          Expanded(
            child: AutoSizeText(
              AppStrings.noFavorites,
              style: Theme.of(context).textTheme.headlineMedium,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
