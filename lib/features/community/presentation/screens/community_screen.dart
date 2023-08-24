import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/utils/appstrings.dart';
import 'package:courses_app/core/utils/responsive.dart';
import 'package:courses_app/features/community/presentation/controller/bloc/community_bloc.dart';
import 'package:courses_app/features/community/presentation/screens/add_post_screen.dart';
import 'package:courses_app/features/community/presentation/widgets/posts_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CommunityBloc>(context)..add(GetPostsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(AppStrings.community),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.bottomToTop,
                          child: const AddPostScreen()));
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(Responsive.getWidth(context) * .02),
          child: BlocBuilder<CommunityBloc, CommunityState>(
            buildWhen: (previous, current) {
              return previous is GetPostsloadingState ||
                  current is GetPostsloadedState;
            },
            builder: (context, state) {
              if (state is GetPostsloadingState) {
                return Center(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[200]!,
                    child: Container(
                      height: Responsive.getHeight(context) * .25,
                      width: Responsive.getWidth(context),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                );
              } else if (state is GetPostsloadedState) {
                return PostsList(posts: state.posts);
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
