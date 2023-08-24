import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:courses_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CourseCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final int price;
  final double rating;
  const CourseCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.price,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.getHeight(context) * .15,
      width: Responsive.getWidth(context) * 60,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            SizedBox(
              width: Responsive.getWidth(context) * .35,
              height: Responsive.getHeight(context) * .40,
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.fill),
                )),
                placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[200]!,
                    child: Container(
                      height: Responsive.getHeight(context) * .20,
                      width: Responsive.getWidth(context) * 20,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    )),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error_outline),
              ),
            ),
            SizedBox(
              width: Responsive.getWidth(context) * .02,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AutoSizeText(
                      title,
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(
                    height: Responsive.getHeight(context) * .01,
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        SizedBox(
                          width: Responsive.getWidth(context) * .07,
                          child: AutoSizeText(
                            rating.toString(),
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                          ),
                        ),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Responsive.getHeight(context) * .01,
                  ),
                  Expanded(
                    child: AutoSizeText(
                      '$price \$',
                      style: Theme.of(context).textTheme.titleMedium,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
