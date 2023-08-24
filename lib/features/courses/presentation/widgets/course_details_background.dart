import 'package:cached_network_image/cached_network_image.dart';
import 'package:courses_app/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class CourseDetailsBackground extends StatelessWidget {
  final String imageUrl;
  const CourseDetailsBackground({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          errorWidget: (context, url, error) => const Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
            ),
          ),
          width: double.infinity,
          height: Responsive.getHeight(context) * .60,
          fit: BoxFit.fill,
        ),
        SizedBox(
          height: Responsive.getHeight(context) * .40,
        )
      ],
    );
  }
}
