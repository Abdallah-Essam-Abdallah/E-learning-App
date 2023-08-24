import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/appstrings.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Responsive.getWidth(context) * .01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Responsive.getHeight(context) * .20,
            ),
            Lottie.asset(
              'assets/lotties/nointernet.json',
              fit: BoxFit.cover,
              width: Responsive.getWidth(context),
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .03,
            ),
            Expanded(
              child: AutoSizeText(
                AppStrings.internetFaliureMessage,
                style: Theme.of(context).textTheme.headlineMedium,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
