import 'package:auto_size_text/auto_size_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/chache_helper/chache_helper.dart';
import '../../../../core/components/text_form_field.dart';
import '../../../../core/utils/appstrings.dart';
import '../../../../core/utils/responsive.dart';
import '../controller/authentication_bloc/authentication_bloc.dart';
import '../screens/login_screen.dart';

class SignupCardTextFields extends StatefulWidget {
  const SignupCardTextFields({super.key});

  @override
  State<SignupCardTextFields> createState() => _SignupCardTextFieldsState();
}

class _SignupCardTextFieldsState extends State<SignupCardTextFields> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController signupEmailController = TextEditingController();

  final TextEditingController signupPasswordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  bool isVisible = true;

  bool isVisible2 = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            AppTextFormField(
              controller: nameController,
              hintText: AppStrings.name,
              prefixIcon: const Icon(Icons.text_fields),
              obscureText: false,
              keyboardType: TextInputType.name,
              validator: (name) {
                return name!.isEmpty ? AppStrings.emptyName : null;
              },
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .01,
            ),
            AppTextFormField(
              controller: signupEmailController,
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
              controller: signupPasswordController,
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
            AppTextFormField(
              controller: confirmPasswordController,
              hintText: AppStrings.confirmPassword,
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible2 = !isVisible2;
                    });
                  },
                  icon: isVisible2
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off)),
              obscureText: isVisible2,
              keyboardType: TextInputType.visiblePassword,
              validator: (password) {
                if (password!.isEmpty) {
                  return AppStrings.emptyPassword;
                } else if (password.length < 8) {
                  return AppStrings.shortPassword;
                } else if (signupPasswordController.text !=
                    confirmPasswordController.text) {
                  return AppStrings.passwordDoNotMatch;
                }
                return null;
              },
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .01,
            ),
            AppTextFormField(
              controller: phoneController,
              hintText: AppStrings.phone,
              prefixIcon: const Icon(Icons.phone_android),
              obscureText: false,
              keyboardType: TextInputType.phone,
              validator: (phone) {
                return phone!.isEmpty || phone.length < 11
                    ? AppStrings.emptyPhone
                    : null;
              },
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .05,
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
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(SignUpEvent(
                                        email: signupEmailController.text,
                                        password: signupPasswordController.text,
                                        phoneNumber: phoneController.text,
                                        userName: nameController.text));
                                CacheHelper.setBoolean(
                                    key: 'isLoggedIn', value: true);
                              }
                            },
                            child: SizedBox(
                                width: Responsive.getWidth(context) * .40,
                                child: const AutoSizeText(
                                  AppStrings.signUp,
                                  textAlign: TextAlign.center,
                                )));
                  },
                ),
              ),
            ),
            SizedBox(
              height: Responsive.getHeight(context) * .03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AutoSizeText(
                  AppStrings.alreadyHaveAnAccount,
                  maxLines: 1,
                ),
                TextButton(
                    onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const LogInScreen()))),
                    child: const AutoSizeText(
                      AppStrings.login,
                      maxLines: 1,
                    ))
              ],
            ),
          ],
        ));
  }

  @override
  void dispose() {
    signupEmailController.dispose();

    signupPasswordController.dispose();

    confirmPasswordController.dispose();

    nameController.dispose();

    phoneController.dispose();
    super.dispose();
  }
}
