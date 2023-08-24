import 'package:flutter/material.dart';

import '../../../../core/utils/responsive.dart';

class BackgroundWidget extends StatelessWidget {
  const BackgroundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.getHeight(context),
      width: Responsive.getWidth(context),
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [
            Color.fromARGB(255, 122, 127, 160),
            Color.fromARGB(255, 179, 179, 241),
          ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              tileMode: TileMode.repeated)),
    );
  }
}
