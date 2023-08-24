import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:courses_app/features/community/domain/entity/comment_entity.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/dateformater.dart';
import '../../../../core/utils/responsive.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.comment});
  final CommentEntity comment;
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: Responsive.getWidth(context) * .05,
              backgroundImage: CachedNetworkImageProvider(comment.userImage),
            ),
            SizedBox(
              width: Responsive.getWidth(context) * .01,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(150, 2, 2, 2)),
                    child: Padding(
                      padding:
                          EdgeInsets.all(Responsive.getWidth(context) * .01),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: Responsive.getHeight(context) * .03,
                            child: AutoSizeText(
                              comment.userName,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                      color: const Color.fromARGB(
                                          255, 207, 204, 204)),
                              maxLines: 1,
                            ),
                          ),
                          AutoSizeText(
                            comment.text,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: Colors.white, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Responsive.getHeight(context) * .001,
                  ),
                  AutoSizeText(
                    DateFormater.formatDateTimeToRelative(
                      comment.commentingTime,
                    ),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Colors.grey, fontSize: 5),
                  )
                ],
              ),
            ),
          ],
        )),
      ],
    );
  }
}
