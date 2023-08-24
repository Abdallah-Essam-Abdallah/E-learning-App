import 'package:auto_size_text/auto_size_text.dart';

import 'package:courses_app/core/utils/appstrings.dart';

import 'package:courses_app/features/favorites/presentation/favorites_bloc/favorites_bloc.dart';
import 'package:courses_app/features/favorites/presentation/widgets/favoriteslist_widget.dart';
import 'package:courses_app/features/favorites/presentation/widgets/nofavorite_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesBloc = BlocProvider.of<FavoritesBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const AutoSizeText(AppStrings.favorites),
        ),
        body: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            return favoritesBloc.favoriteCourses.isEmpty
                ? const NoFavoriteCoursesWidget()
                : const FavoritesListWidget();
          },
        ));
  }
}
