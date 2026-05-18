import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_validators/app_validators.dart';
import '../../../core/resources/colors/colors_manager.dart';
import '../../../core/resources/images/images_manager.dart';
import '../../../core/resources/routes/routes_manager.dart';
import '../../../core/utils/dialog.dart';
import '../../../l10n/app_localizations.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import 'cubit/sign_up_cubit.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterLoading) {
            DialogUtils.showLoadingDialog(context, "Registering...");
          } else if (state is RegisterSuccess) {
            DialogUtils.hideDialog(context);
            DialogUtils.showMessage(
              context,
              title: "Success",
              message: "Account created",
              posActionTitle: "Ok",
              posAction: () => Navigator.pushReplacementNamed(context, RoutesManager.signIn),
            );
          } else if (state is RegisterFailure) {
            DialogUtils.hideDialog(context);
            DialogUtils.showMessage(context, title: "Error", message: state.errorMessage);
          }
        },
        builder: (context, state) {
          var cubit = context.read<RegisterCubit>();
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              elevation: 0 ,
              title: Text(AppLocalizations.of(context)!.register),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: ColorsManager.blue),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  children: [
                    Expanded(child: Image.asset(ImagesManager.logo)),
                    Expanded(
                      flex: 4,
                      child: SingleChildScrollView(
                        padding: REdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            CustomTextFormField(
                              validator: AppValidators.validateName,
                              controller: nameController,
                              label: AppLocalizations.of(context)!.name,
                              prefixIcon: Icons.person,
                            ),
                            SizedBox(height: 16.h),
                            CustomTextFormField(
                              validator: AppValidators.validateEmail,
                              controller: emailController,
                              label: AppLocalizations.of(context)!.email,
                              prefixIcon: Icons.email,
                            ),
                            SizedBox(height: 16.h),
                            CustomTextFormField(
                              validator: AppValidators.validatePassword,
                              controller: passwordController,
                              label: AppLocalizations.of(context)!.password,
                              prefixIcon: Icons.lock,
                              suffixIcon: cubit.secure ? Icons.visibility_off : Icons.visibility,
                              isSecure: cubit.secure,
                              onClick: cubit.togglePassword,
                            ),
                            SizedBox(height: 16.h),
                            CustomTextFormField(
                              validator: (value) => AppValidators.validateRePassword(value, passwordController.text),
                              controller: rePasswordController,
                              label: AppLocalizations.of(context)!.re_password,
                              prefixIcon: Icons.lock,
                              suffixIcon: cubit.resecure ? Icons.visibility_off : Icons.visibility,
                              isSecure: cubit.resecure,
                              onClick: cubit.toggleRePassword,
                            ),
                            SizedBox(height: 24.h),
                            CustomElevatedButton(
                              title: AppLocalizations.of(context)!.create_account,
                              onClick: () {
                                if (formKey.currentState!.validate()) {
                                  cubit.register(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
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