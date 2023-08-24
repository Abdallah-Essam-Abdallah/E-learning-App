import 'package:courses_app/features/authentication/presentation/screens/verifyemail_screen.dart';
import 'package:courses_app/features/authentication/presentation/widgets/signup_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/snack_bar.dart';
import '../controller/authentication_bloc/authentication_bloc.dart';
import '../widgets/background_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationSignUpLoadedState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const VerifyEmailScreen())));
            } else if (state is AuthenticationErrorState) {
              showSnackBar(state.error, context);
            }
          },
          builder: (context, state) {
            return const Stack(
              alignment: Alignment.center,
              children: [BackgroundWidget(), SignUpCard()],
            );
          },
        ),
      ),
    );
  }
}
