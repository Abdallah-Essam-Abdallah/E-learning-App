import 'package:courses_app/core/utils/responsive.dart';
import 'package:courses_app/features/rating/presentation/controller/bloc/rating_bloc.dart';
import 'package:courses_app/features/rating/presentation/widgets/norating_widget.dart';
import 'package:courses_app/features/rating/presentation/widgets/ratings_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottomsheet_button.dart';

class RatingScreen extends StatelessWidget {
  const RatingScreen({
    super.key,
    required this.course,
  });
  final String course;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<RatingBloc>(context)
        ..add(GetRatingEvent(course: course)),
      child: Padding(
        padding: EdgeInsets.all(Responsive.getHeight(context) * .01),
        child: Column(
          children: [
            BlocBuilder<RatingBloc, RatingState>(
              builder: (context, state) {
                if (state is GetRatingLoadingState) {
                  return Column(
                    children: [
                      SizedBox(height: Responsive.getHeight(context) * .07),
                      const CircularProgressIndicator.adaptive(),
                      SizedBox(height: Responsive.getHeight(context) * .07),
                    ],
                  );
                } else if (state is GetRatingLoadedState) {
                  if (state.ratings.isEmpty) {
                    return Expanded(child: NoRatingWidget(course: course));
                  } else {
                    return Expanded(child: RatingsList(ratings: state.ratings));
                  }
                } else {
                  return const SizedBox();
                }
              },
            ),
            BottomSheetButton(course: course),
          ],
        ),
      ),
    );
  }
}
