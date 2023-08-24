import 'package:courses_app/core/components/snack_bar.dart';

import 'package:courses_app/features/authentication/presentation/widgets/background_widget.dart';
import 'package:courses_app/features/authentication/presentation/widgets/login_card_widget.dart';
import 'package:courses_app/features/courses/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/authentication_bloc/authentication_bloc.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSignInWithEmailAndPassworsLoadedState ||
                state is AuthenticationSignInWithGoogleLoadedState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const HomeScreen())));
            } else if (state is AuthenticationErrorState) {
              showSnackBar(state.error, context);
            }
          },
          builder: (context, state) {
            return const Stack(
              alignment: Alignment.center,
              children: [BackgroundWidget(), LoginCardWidget()],
            );
          },
        ),
      ),
    );
  }
}
