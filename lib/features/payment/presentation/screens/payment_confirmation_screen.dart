import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/features/courses/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/appstrings.dart';
import '../../../../core/utils/responsive.dart';

class PaymentConfirmation extends StatelessWidget {
  const PaymentConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(Responsive.getWidth(context) * .01),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green,
            size: Responsive.getWidth(context) * .50,
          ),
          SizedBox(
            height: Responsive.getHeight(context) * .03,
          ),
          SizedBox(
            width: Responsive.getWidth(context),
            height: Responsive.getHeight(context) * .10,
            child: AutoSizeText(
              AppStrings.paymentConfirmation,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
          SizedBox(
            height: Responsive.getHeight(context) * .01,
          ),
          SizedBox(
              width: Responsive.getWidth(context) * .50,
              height: Responsive.getHeight(context) * .05,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const HomeScreen())));
                  },
                  child: const AutoSizeText(AppStrings.home))),
        ],
      ),
    ));
  }
}
