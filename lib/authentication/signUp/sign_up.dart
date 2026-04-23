import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/authentication/widgets/custom_text_button.dart';
import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/core/app_validators/app_validators.dart';
import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/core/resources/images/images_manager.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/core/utils/dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../firebase_service/firestore/auth_service.dart';
import '../../l10n/app_localizations.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;
  bool secure = true;
  bool resecure = true;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.register),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          color: ColorsManager.blue,
        ),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              Expanded(flex: 1, child: Image.asset(ImagesManager.logo)),
              Expanded(
                flex: 4,
                child: Padding(
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
                        suffixIcon: secure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        isSecure: secure,
                        onClick: _onclick,
                      ),
                      SizedBox(height: 16.h),

                      CustomTextFormField(
                        validator: (value) => AppValidators.validateRePassword(
                          value,
                          passwordController.text,
                        ),
                        controller: rePasswordController,
                        label: AppLocalizations.of(context)!.re_password,
                        prefixIcon: Icons.lock,
                        suffixIcon: resecure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        isSecure: resecure,
                        onClick: _reOnclick,
                      ),
                      SizedBox(height: 16.h),

                      CustomElevatedButton(
                        title: AppLocalizations.of(context)!.create_account,
                        onClick: register,
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextButton(
                            title: AppLocalizations.of(context)!.login,
                            text: AppLocalizations.of(
                              context,
                            )!.already_have_account,
                            onClick: () {
                              Navigator.pushReplacementNamed(
                                context,
                                RoutesManager.signIn,
                              );
                            },
                          ),
                        ],
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
  }

  void _onclick() {
    setState(() {
      secure = !secure;
    });
  }

  void _reOnclick() {
    setState(() {
      resecure = !resecure;
    });
  }
  void register() async {
    if (!formKey.currentState!.validate()) return;

    DialogUtils.showLoadingDialog(context, "Registering...");

    final result = await AuthService.register(
      emailController.text,
      passwordController.text,
      nameController.text,
    );

    DialogUtils.hideDialog(context);

    if (result != null) {
      switch (result) {
        case 'weak-password':
          DialogUtils.showMessage(context, title: "Error", message: "Weak password");
          break;

        case 'email-already-in-use':
          DialogUtils.showMessage(context, title: "Error", message: "Email already used");
          break;

        default:
          DialogUtils.showMessage(context, title: "Error", message: "Something went wrong");
      }
      return;
    }

    DialogUtils.showMessage(context, title: "Success", message: "Account created",posActionTitle: "Ok",posAction: (){Navigator.pushReplacementNamed(context, RoutesManager.signIn);});

  }
}
