import 'package:auto_size_text/auto_size_text.dart';
import 'package:courses_app/core/components/snack_bar.dart';
import 'package:courses_app/core/components/text_form_field.dart';
import 'package:courses_app/core/utils/appstrings.dart';
import 'package:courses_app/core/utils/responsive.dart';
import 'package:courses_app/features/payment/presentation/screens/payment_screen.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/payment_bloc/payment_bloc.dart';
import '/core/dependency_injection/injection.dart' as di;

class PaymentDetailsScreen extends StatefulWidget {
  const PaymentDetailsScreen(
      {super.key, required this.price, required this.course});
  final String price;
  final String course;

  @override
  State<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends State<PaymentDetailsScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    di.getIt<PaymentBloc>().add(RequestPaymentOrderEvent(price: widget.price));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AutoSizeText(AppStrings.paymentInformation),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Responsive.getHeight(context) * .01),
              AutoSizeText(
                AppStrings.paymentInformation,
                style: Theme.of(context).textTheme.headlineSmall,
                maxLines: 1,
              ),
              SizedBox(height: Responsive.getHeight(context) * .01),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  SizedBox(
                      height: Responsive.getHeight(context) * .65,
                      width: Responsive.getWidth(context)),
                  Container(
                    height: Responsive.getHeight(context) * .50,
                    width: Responsive.getWidth(context) * .90,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromARGB(255, 218, 214, 214)),
                    child: Padding(
                      padding:
                          EdgeInsets.all(Responsive.getWidth(context) * .02),
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: Responsive.getHeight(context) * .16),
                              Row(
                                children: [
                                  Expanded(
                                    child: AppTextFormField(
                                      controller: firstNameController,
                                      hintText: AppStrings.firstName,
                                      prefixIcon: const Icon(Icons.text_fields),
                                      obscureText: false,
                                      keyboardType: TextInputType.name,
                                      validator: (name) {
                                        return name!.isEmpty
                                            ? AppStrings.emptyName
                                            : null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          Responsive.getWidth(context) * .01),
                                  Expanded(
                                      child: AppTextFormField(
                                    controller: lastNameController,
                                    hintText: AppStrings.lastName,
                                    prefixIcon: const Icon(Icons.text_fields),
                                    obscureText: false,
                                    keyboardType: TextInputType.name,
                                    validator: (name) {
                                      return name!.isEmpty
                                          ? AppStrings.emptyName
                                          : null;
                                    },
                                  )),
                                ],
                              ),
                              SizedBox(
                                  height: Responsive.getHeight(context) * .02),
                              AppTextFormField(
                                controller: emailController,
                                hintText: AppStrings.email,
                                prefixIcon: const Icon(Icons.email),
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                                validator: (email) {
                                  if (email!.isEmpty ||
                                      !EmailValidator.validate(email)) {
                                    return AppStrings.invalidEmail;
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                  height: Responsive.getHeight(context) * .02),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: Responsive.getHeight(context) * .02,
                    child: SizedBox(
                      height: Responsive.getHeight(context) * .20,
                      width: Responsive.getWidth(context) * .70,
                      child: Image.asset(
                        AppStrings.visaImage,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  )
                ],
              ),
              const Divider(
                thickness: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const AutoSizeText(AppStrings.total),
                  AutoSizeText(widget.price),
                ],
              ),
              SizedBox(height: Responsive.getHeight(context) * .03),
              SizedBox(
                  width: Responsive.getWidth(context) * .50,
                  child: BlocConsumer<PaymentBloc, PaymentState>(
                    listener: (context, state) {
                      if (state is RequestPaymentLoadedState) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => PaymentScreen(
                                      course: widget.course,
                                    ))));
                      } else if (state is RequestPaymentErrorState) {
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
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<PaymentBloc>(context).add(
                                RequestPaymentEvent(
                                    firstname: firstNameController.text,
                                    lastname: lastNameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    price: widget.price));
                          }
                        },
                        child: SizedBox(
                          width: Responsive.getWidth(context) * .50,
                          child: const AutoSizeText(
                            AppStrings.confirm,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
