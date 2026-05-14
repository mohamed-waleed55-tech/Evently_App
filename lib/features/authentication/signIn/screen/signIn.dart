
import 'package:evently/core/app_validators/app_validators.dart';
import 'package:evently/core/resources/images/images_manager.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/core/widgets/login_with_google.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/dialog.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import '../cubit/login_cubit.dart';

class SignIn extends StatelessWidget {
  SignIn({super.key});

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            DialogUtils.showLoadingDialog(context, "Logging in...");
          } else if (state is LoginSuccess) {
            DialogUtils.hideDialog(context);
            Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
          } else if (state is LoginFailure) {
            DialogUtils.hideDialog(context);
            DialogUtils.showMessage(context, title: "Error", message: state.errorMessage);
          }
        },
        builder: (context, state) {
          var cubit = context.read<LoginCubit>();
          return Scaffold(
            resizeToAvoidBottomInset: false,
            body: Padding(
              padding: REdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(child: Image.asset(ImagesManager.logo)),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: emailController,
                            validator: AppValidators.validateEmail,
                            label: AppLocalizations.of(context)!.email,
                            prefixIcon: Icons.email,
                          ),
                          SizedBox(height: 16.h),
                          CustomTextFormField(
                            controller: passwordController,
                            validator: AppValidators.validatePassword,
                            label: AppLocalizations.of(context)!.password,
                            prefixIcon: Icons.lock,
                            isSecure: cubit.isSecure,
                            suffixIcon: cubit.isSecure ? Icons.visibility_off : Icons.visibility,
                            onClick: () => cubit.togglePasswordVisibility(),
                          ),
                          CustomElevatedButton(
                            title: AppLocalizations.of(context)!.login,
                            onClick: () {
                              if (formKey.currentState!.validate()) {
                                cubit.login(emailController.text, passwordController.text);
                              }
                            },
                          ),
                          SizedBox(height: 24.h),
                          LoginWithProviders(
                            title: AppLocalizations.of(context)!.login_with_google,
                            onClick: () => cubit.loginWithGoogle(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}