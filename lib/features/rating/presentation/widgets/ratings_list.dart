import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:courses_app/features/rating/domain/entity/rating_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/utils/responsive.dart';

class RatingsList extends StatelessWidget {
  const RatingsList({
    super.key,
    required this.ratings,
  });

  final List<RatingEntity> ratings;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            radius: Responsive.getWidth(context) * .10,
            backgroundImage: CachedNetworkImageProvider(
              ratings[index].userImage,
            ),
          ),
          subtitle: AutoSizeText(
            ratings[index].comment,
            style: Theme.of(context).textTheme.titleLarge,
            maxLines: 3,
          ),
          title: RatingBarIndicator(
            rating: ratings[index].stars,
            itemBuilder: (context, index) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            itemSize: Responsive.getWidth(context) * .05,
            itemCount: 5,
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
      itemCount: ratings.length,
    );
  }
}
