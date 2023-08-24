import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/components/snack_bar.dart';
import 'package:courses_app/features/profile/presentation/controller/profile_bloc/profile_bloc.dart';
import 'package:courses_app/features/rating/domain/entity/rating_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../core/components/text_form_field.dart';
import '../../../../core/utils/appstrings.dart';
import '../../../../core/utils/responsive.dart';
import '../controller/bloc/rating_bloc.dart';

class BottomSheetButton extends StatefulWidget {
  const BottomSheetButton({super.key, required this.course});
  final String course;

  @override
  State<BottomSheetButton> createState() => _BottomSheetButtonState();
}

class _BottomSheetButtonState extends State<BottomSheetButton> {
  final TextEditingController commentController = TextEditingController();
  List<RatingEntity>? ratings;
  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final RatingBloc ratingBloc = BlocProvider.of<RatingBloc>(context);
    final ProfileBloc profileBloc = BlocProvider.of<ProfileBloc>(context);
    return BlocProvider.value(
      value: BlocProvider.of<RatingBloc>(context),
      child: SizedBox(
        width: Responsive.getWidth(context) * .50,
        height: Responsive.getHeight(context) * .05,
        child: ElevatedButton(
            onPressed: () {
              ratingBloc.initialRating = 0;
              showModalBottomSheet(
                isDismissible: false,
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15))),
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(
                        Responsive.getWidth(context) * .02,
                      ),
                      child: SizedBox(
                        height: Responsive.getHeight(context),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              initialRating: 0,
                              minRating: 1,
                              direction: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                BlocProvider.of<RatingBloc>(context).add(
                                    UpdateRatingValueEvent(
                                        ratingValue: rating));
                              },
                            ),
                            SizedBox(
                              height: Responsive.getHeight(context) * .01,
                            ),
                            BlocBuilder<RatingBloc, RatingState>(
                              builder: (context, state) {
                                if (ratingBloc.initialRating == 0) {
                                  ratingBloc.ratingFeedbak = '';
                                } else if (ratingBloc.initialRating <= 2) {
                                  ratingBloc.ratingFeedbak =
                                      AppStrings.badRating;
                                } else if (ratingBloc.initialRating == 3) {
                                  ratingBloc.ratingFeedbak =
                                      AppStrings.averageRating;
                                } else {
                                  ratingBloc.ratingFeedbak =
                                      AppStrings.goodRating;
                                }
                                return AutoSizeText(
                                  ratingBloc.ratingFeedbak,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                );
                              },
                            ),
                            SizedBox(
                              height: Responsive.getHeight(context) * .01,
                            ),
                            AppTextFormField(
                              hintText: AppStrings.addRating,
                              obscureText: false,
                              keyboardType: TextInputType.text,
                              controller: commentController,
                            ),
                            SizedBox(
                              height: Responsive.getHeight(context) * .05,
                            ),
                            SizedBox(
                                width: Responsive.getWidth(context) * .50,
                                height: Responsive.getHeight(context) * .05,
                                child: BlocConsumer<RatingBloc, RatingState>(
                                  listener: (context, state) {
                                    if (state is AddRatingLoadedState) {
                                      BlocProvider.of<RatingBloc>(context).add(
                                          GetRatingEvent(
                                              course: widget.course));
                                      Navigator.pop(context);
                                      commentController.clear();
                                    } else if (state is AddRatingErrorState) {
                                      showSnackBar(state.error, context);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AddRatingLoadingState) {
                                      return const LinearProgressIndicator();
                                    } else {
                                      return ElevatedButton(
                                          onPressed: () {
                                            BlocProvider.of<RatingBloc>(context)
                                                .add(AddRatingEvent(
                                                    course: widget.course,
                                                    comment: commentController
                                                        .value.text,
                                                    stars: ratingBloc
                                                        .initialRating,
                                                    userName: profileBloc
                                                            .user!.userName ??
                                                        '',
                                                    userImage: profileBloc
                                                            .user!.image ??
                                                        AppStrings
                                                            .profileImage));
                                          },
                                          child: AutoSizeText(
                                            AppStrings.addRating,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall!
                                                .copyWith(
                                                    color: const Color.fromARGB(
                                                        255, 240, 235, 235)),
                                          ));
                                    }
                                  },
                                )),
                            SizedBox(
                              height: Responsive.getHeight(context) * .01,
                            ),
                            SizedBox(
                              width: Responsive.getWidth(context) * .50,
                              height: Responsive.getHeight(context) * .05,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  BlocProvider.of<RatingBloc>(context).add(
                                      GetRatingEvent(course: widget.course));
                                },
                                child: AutoSizeText(
                                  AppStrings.close,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(
                                          color: const Color.fromARGB(
                                              255, 240, 235, 235)),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  flex: 2,
                  child: AutoSizeText(
                    AppStrings.addRating,
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: const Color.fromARGB(255, 240, 235, 235)),
                  ),
                ),
                const Expanded(child: Icon(Icons.star))
              ],
            )),
      ),
    );
  }
}
