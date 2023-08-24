import 'package:auto_size_text/auto_size_text.dart';

import 'package:courses_app/features/courses/presentation/screens/category_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../core/utils/responsive.dart';
import '../../data/model/category_data.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Responsive.getHeight(context) * .20,
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.leftToRight,
                          alignment: Alignment.bottomCenter,
                          child: CategoryScreen(
                            category: categoryData[index].title,
                          )));
                },
                child: Container(
                  height: Responsive.getHeight(context) * .17,
                  width: Responsive.getWidth(context) * .30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                        image: AssetImage(categoryData[index].image)),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          height: Responsive.getHeight(context) * .17,
                          width: Responsive.getWidth(context) * .30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromARGB(61, 0, 0, 0),
                          )),
                      Center(
                        child: AutoSizeText(
                          categoryData[index].title,
                          style: Theme.of(context).textTheme.labelLarge,
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: Responsive.getWidth(context) * .05,
              );
            },
            itemCount: categoryData.length));
  }
}
