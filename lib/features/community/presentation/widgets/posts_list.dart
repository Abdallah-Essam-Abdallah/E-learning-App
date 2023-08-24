import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:courses_app/features/community/domain/entity/post_entity.dart';
import 'package:courses_app/features/community/presentation/screens/comments_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../core/utils/appstrings.dart';
import '../../../../core/utils/dateformater.dart';
import '../../../../core/utils/responsive.dart';
import '../controller/bloc/community_bloc.dart';

class PostsList extends StatelessWidget {
  const PostsList({super.key, required this.posts});
  final List<PostEntity> posts;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Card(
                    color: const Color.fromARGB(249, 226, 221, 221),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    child: Padding(
                      padding:
                          EdgeInsets.all(Responsive.getWidth(context) * .02),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: Responsive.getWidth(context) * .05,
                                backgroundImage: CachedNetworkImageProvider(
                                    posts[index].userImage),
                              ),
                              SizedBox(
                                width: Responsive.getWidth(context) * .02,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: Responsive.getWidth(context) * .30,
                                    height: Responsive.getWidth(context) * .05,
                                    child: AutoSizeText(
                                      posts[index].userName,
                                      maxLines: 1,
                                    ),
                                  ),
                                  SizedBox(
                                    width: Responsive.getWidth(context) * .50,
                                    height: Responsive.getWidth(context) * .04,
                                    child: AutoSizeText(
                                      DateFormater.formatPostTime(
                                        posts[index].postingTime,
                                      ),
                                      maxLines: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Responsive.getHeight(context) * .02,
                          ),
                          AutoSizeText.rich(
                            TextSpan(text: posts[index].text),
                          ),
                          SizedBox(
                            height: Responsive.getHeight(context) * .01,
                          ),
                          posts[index].image == ""
                              ? const SizedBox()
                              : Image(
                                  image: CachedNetworkImageProvider(
                                      posts[index].image ?? ''),
                                  width: Responsive.getWidth(context),
                                  height: Responsive.getHeight(context) * .30,
                                  fit: BoxFit.cover,
                                ),
                          SizedBox(
                            height: Responsive.getHeight(context) * .02,
                          ),
                          const Divider(),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BlocBuilder<CommunityBloc, CommunityState>(
                                builder: (context, state) {
                                  return IconButton(
                                      onPressed: () {
                                        BlocProvider.of<CommunityBloc>(context)
                                            .add(AddLikeEvent(
                                          post: posts[index],
                                        ));
                                      },
                                      icon: !posts[index].likes.contains(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid)
                                          ? const Icon(
                                              Icons.favorite_outline,
                                              color: Colors.black,
                                            )
                                          : const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            ));
                                },
                              ),
                              Expanded(
                                child: AutoSizeText(
                                    '${posts[index].likes.length} ${AppStrings.likes}'),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.bottomToTop,
                                            child: CommentsScreen(
                                              postId: posts[index].postId,
                                            )));
                                  },
                                  icon: const Icon(Icons.comment)),
                              Expanded(
                                child: AutoSizeText(
                                    '${posts[index].comments} ${AppStrings.comments}'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: Responsive.getHeight(context) * .01,
          );
        },
        itemCount: posts.length);
  }
}
