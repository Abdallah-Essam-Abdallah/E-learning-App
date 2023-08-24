import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/chache_helper/chache_helper.dart';
import '../../../../core/components/text_form_field.dart';
import '../../../../core/utils/appstrings.dart';
import '../../../../core/utils/responsive.dart';
import '../controller/authentication_bloc/authentication_bloc.dart';
import '../screens/reset_password_screen.dart';

class UpperLoginCardWidget extends StatefulWidget {
  const UpperLoginCardWidget({super.key});

  @override
  State<UpperLoginCardWidget> createState() => _UpperLoginCardWidgetState();
}

class _UpperLoginCardWidgetState extends State<UpperLoginCardWidget> {
  final loginFormKey = GlobalKey<FormState>();

  final TextEditingController loginEmailController = TextEditingController();

  final TextEditingController loginPasswordController = TextEditingController();

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginFormKey,
      child: Column(
        children: [
          SizedBox(
            width: Responsive.getWidth(context) * .50,
            child: AutoSizeText(
              AppStrings.login,
              style: Theme.of(context).textTheme.headlineMedium,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Responsive.getHeight(context) * .01,
          ),
          SizedBox(
            width: Responsive.getWidth(context) * .80,
            child: AutoSizeText(
              AppStrings.loginDescription,
              style: Theme.of(context).textTheme.titleLarge,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: Responsive.getHeight(context) * .03,
          ),
          AppTextFormField(
            controller: loginEmailController,
            hintText: AppStrings.email,
            prefixIcon: const Icon(Icons.email),
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            validator: (email) {
              if (email!.isEmpty || !EmailValidator.validate(email)) {
                return AppStrings.invalidEmail;
              }
              return null;
            },
          ),
          SizedBox(
            height: Responsive.getHeight(context) * .01,
          ),
          AppTextFormField(
            controller: loginPasswordController,
            hintText: AppStrings.password,
            prefixIcon: const Icon(Icons.lock),
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                icon: isVisible
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off)),
            obscureText: isVisible,
            keyboardType: TextInputType.visiblePassword,
            validator: (password) {
              if (password!.isEmpty) {
                return AppStrings.emptyPassword;
              } else if (password.length < 8) {
                return AppStrings.shortPassword;
              }
              return null;
            },
          ),
          SizedBox(
            height: Responsive.getHeight(context) * .01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) =>
                                const ResetPasswordScreen())));
                  },
                  child: const AutoSizeText(AppStrings.forgotPassword)),
            ],
          ),
          SizedBox(
            height: Responsive.getHeight(context) * .03,
          ),
          Center(
            child: SizedBox(
              width: Responsive.getWidth(context) * .50,
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  return state is AuthenticationLoadingState
                      ? const Center(
                          child: CircularProgressIndicator.adaptive(),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            if (loginFormKey.currentState!.validate()) {
                              BlocProvider.of<AuthenticationBloc>(context).add(
                                  SignInWithEmailAndPasswordEvent(
                                      email: loginEmailController.text.trim(),
                                      password:
                                          loginPasswordController.text.trim()));
                              CacheHelper.setBoolean(
                                  key: 'isLoggedIn', value: true);
                            }
                          },
                          child: const Text(AppStrings.login));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    loginEmailController.dispose();

    loginPasswordController.dispose();

    super.dispose();
  }
}
