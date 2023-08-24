import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/components/no_internet_widget.dart';
import 'package:courses_app/core/utils/responsive.dart';
import 'package:courses_app/features/courses/presentation/screens/search_screen.dart';
import 'package:courses_app/features/courses/presentation/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/connectivity_cubit/internet_cubit.dart';
import '../../../../core/utils/appstrings.dart';
import '../widgets/categories_widget.dart';
import '../widgets/topratedwidget.dart';
import '../widgets/upperhomescreen_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InternetCubit, InternetState>(
      builder: (context, state) {
        if (state is DisconnectedInternetState) {
          return const NoInternetWidget();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const AutoSizeText(AppStrings.home),
              actions: [
                IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const SearchScreen()))),
                    icon: const Icon(Icons.search))
              ],
            ),
            drawer: const AppDrawer(),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(
                  right: Responsive.getWidth(context) * .02,
                  left: Responsive.getWidth(context) * .02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const UpperHomeScreenWidget(),
                  SizedBox(
                    height: Responsive.getHeight(context) * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AutoSizeText(
                          AppStrings.categories,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Responsive.getHeight(context) * .01,
                  ),
                  const CategoriesWidget(),
                  SizedBox(
                    height: Responsive.getHeight(context) * .01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: AutoSizeText(
                          AppStrings.topRated,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {},
                            child: const Row(
                              children: [
                                Text(AppStrings.seeMore),
                                Icon(Icons.arrow_forward_ios_outlined)
                              ],
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Responsive.getHeight(context) * .01,
                  ),
                  const TopRatedWidget()
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
