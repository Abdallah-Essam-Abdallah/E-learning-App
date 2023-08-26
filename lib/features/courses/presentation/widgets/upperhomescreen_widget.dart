import 'package:auto_size_text/auto_size_text.dart';

import 'package:courses_app/core/chache_helper/chache_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shimmer/shimmer.dart';

import '../../../../core/utils/appstrings.dart';
import '../../../../core/utils/responsive.dart';

import '../../../profile/presentation/controller/profile_bloc/profile_bloc.dart';

class UpperHomeScreenWidget extends StatelessWidget {
  const UpperHomeScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<ProfileBloc>(context)..add(GetUserDataEvent()),
      child: SizedBox(
        height: Responsive.getHeight(context) * .32,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AutoSizeText(
                AppStrings.hello,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .01,
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is GetUserDataLoadingState &&
                    CacheHelper.getString(key: 'userName') == null) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[200]!,
                    child: Container(
                      height: Responsive.getHeight(context) * .01,
                      width: Responsive.getWidth(context) * .25,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  );
                } else if (state is GetUserDataLoadedState &&
                    CacheHelper.getString(key: 'userName') == null) {
                  CacheHelper.setString(
                      key: 'userName',
                      value: state.user.userName);
                  return Expanded(
                    child: AutoSizeText(
                      state.user.userName,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                } else if (CacheHelper.getString(key: 'userName') != null) {
                  return Expanded(
                    child: AutoSizeText(
                      CacheHelper.getString(key: 'userName')!,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  );
                }
                return const SizedBox();
              },
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .02,
            ),
            Center(
              child: Container(
                height: Responsive.getHeight(context) * .20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.indigo,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Image.asset(
                      'assets/images/ad.png',
                    )),
                    Expanded(
                        // flex: 2,
                        child: AutoSizeText(
                      AppStrings.adTitle,
                      style: Theme.of(context).textTheme.displaySmall,
                      maxLines: 3,
                    ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .02,
            ),
          ],
        ),
      ),
    );
  }
}
