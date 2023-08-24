import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/utils/appstrings.dart';
import 'package:courses_app/core/utils/responsive.dart';
import 'package:courses_app/features/payment/presentation/screens/payment_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/snack_bar.dart';
import '../../../payment/presentation/controller/payment_bloc/payment_bloc.dart';

class CourseDetailsCard extends StatelessWidget {
  final String title;
  final String description;
  final double rating;
  final String time;
  final int price;

  const CourseDetailsCard(
      {super.key,
      required this.title,
      required this.description,
      required this.rating,
      required this.time,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.getWidth(context),
      height: Responsive.getHeight(context) * .50,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: Color.fromARGB(255, 240, 234, 234),
      ),
      child: Padding(
        padding: EdgeInsets.all(Responsive.getHeight(context) * .02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: Responsive.getHeight(context) * .01,
            ),
            Center(
              child: AutoSizeText(
                title,
                maxLines: 1,
                style: Theme.of(context).textTheme.titleLarge!,
              ),
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .02,
            ),
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                SizedBox(
                  width: Responsive.getWidth(context) * .01,
                ),
                Expanded(
                  child: AutoSizeText(
                    rating.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.watch_later_outlined,
                  color: Colors.blue,
                ),
                SizedBox(
                  width: Responsive.getWidth(context) * .01,
                ),
                Expanded(
                  child: AutoSizeText(
                    time,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 16),
                  ),
                )
              ],
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .02,
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .03,
              width: Responsive.getWidth(context) * .30,
              child: AutoSizeText(
                '${AppStrings.price}$price\$',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontSize: 16),
              ),
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .02,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: AutoSizeText.rich(
                    maxLines: description.length,
                    TextSpan(
                        text: description,
                        style: Theme.of(context).textTheme.headlineSmall!)),
              ),
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .01,
            ),
            Center(
              child: SizedBox(
                width: Responsive.getWidth(context) * .80,
                height: Responsive.getWidth(context) * .10,
                child: BlocConsumer<PaymentBloc, PaymentState>(
                  listener: (context, state) {
                    if (state is RequestPaymentAuthLoadedState) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => PaymentDetailsScreen(
                                    price: price.toString(),
                                    course: title,
                                  ))));
                    } else if (state is RequestPaymentAuthErrorState) {
                      showSnackBar(state.error, context);
                    }
                  },
                  builder: (context, state) {
                    if (state is PaymenLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    return ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<PaymentBloc>(context)
                              .add(RequestPaymentAuthEvent());
                        },
                        child: SizedBox(
                          width: Responsive.getWidth(context) * .80,
                          child: AutoSizeText(
                            AppStrings.enrollNow,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    color: const Color.fromARGB(
                                        255, 240, 235, 235)),
                          ),
                        ));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
