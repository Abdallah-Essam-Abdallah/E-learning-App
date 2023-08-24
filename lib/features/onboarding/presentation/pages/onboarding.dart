import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/chache_helper/chache_helper.dart';
import 'package:courses_app/core/utils/appstrings.dart';
import 'package:courses_app/core/utils/responsive.dart';
import 'package:courses_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:courses_app/features/onboarding/data/onboardingdata.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
      controller: pageController,
      physics: const BouncingScrollPhysics(),
      itemCount: onBoardingData.length,
      itemBuilder: ((context, index) => SafeArea(
            child: Padding(
              padding: EdgeInsets.all(Responsive.getHeight(context) * .01),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Responsive.getHeight(context) * .05,
                  ),
                  Image.asset(
                    onBoardingData[index].image,
                    width: double.infinity,
                    height: Responsive.getHeight(context) * .50,
                  ),
                  SizedBox(
                    height: Responsive.getHeight(context) * .05,
                  ),
                  Expanded(
                    child: AutoSizeText(
                      onBoardingData[index].title,
                      style: Theme.of(context).textTheme.headlineMedium,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    height: Responsive.getHeight(context) * .01,
                  ),
                  Expanded(
                    flex: 3,
                    child: AutoSizeText(
                      onBoardingData[index].description,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  ),
                  SizedBox(
                    height: Responsive.getHeight(context) * .03,
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: 3,
                    effect: ExpandingDotsEffect(
                        dotHeight: Responsive.getHeight(context) * .02),
                  ),
                  SizedBox(
                    height: Responsive.getHeight(context) * .02,
                  ),
                  SizedBox(
                    width: Responsive.getWidth(context) * .50,
                    height: Responsive.getHeight(context) * .06,
                    child: ElevatedButton(
                        onPressed: () {
                          index <= 1
                              ? pageController.nextPage(
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.easeInToLinear)
                              : {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              const LogInScreen()))),
                                  CacheHelper.setBoolean(
                                      key: 'isOnboardingSkipped', value: true)
                                };
                        },
                        child: AutoSizeText(
                          index <= 1 ? AppStrings.next : AppStrings.getStarted,
                          maxLines: 1,
                          textScaleFactor: 1.5,
                        )),
                  )
                ],
              ),
            ),
          )),
    ));
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
