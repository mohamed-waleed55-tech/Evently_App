import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/authentication/widgets/custom_text_button.dart';
import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/core/app_validators/app_validators.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/core/widgets/login_with_google.dart';
import 'package:evently/authentication/widgets/or_shape.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/resources/images/images_manager.dart';
import '../../core/utils/dialog.dart';
import '../../firebase_service/firestore/auth_service.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  bool secure = true;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: REdgeInsets.all(16.0),
                    child: Image.asset(ImagesManager.logo),
                  ),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                        suffixIcon: secure
                            ? Icons.visibility_off
                            : Icons.visibility,
                        isSecure: secure,
                        onClick: _onClick,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomTextButton(
                            title: AppLocalizations.of(
                              context,
                            )!.forget_password,
                            onClick: () {
                              Navigator.pushNamed(
                                context,
                                RoutesManager.forgetPassword,
                              );
                            },
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),

                      CustomElevatedButton(
                        title: AppLocalizations.of(context)!.login,
                        onClick: login,
                      ),
                      SizedBox(height: 24.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextButton(
                            title: AppLocalizations.of(context)!.create_account,
                            text: AppLocalizations.of(
                              context,
                            )!.dont_have_account,
                            onClick: () {
                              Navigator.pushReplacementNamed(
                                context,
                                RoutesManager.signUp,
                              );
                            },
                          ),
                        ],
                      ),
                      OrShape(),
                      SizedBox(height: 24.h),
                      LoginWithGoogle(
                        title: AppLocalizations.of(context)!.login_with_google,
                        onClick: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void login() async {
    if (!formKey.currentState!.validate()) return;

    DialogUtils.showLoadingDialog(context, "Logging in...");

    final result = await AuthService.login(
      emailController.text.trim(),
      passwordController.text,
    );

    if (!mounted) return;
    DialogUtils.hideDialog(context);

    if (result != null) {
      switch (result) {
        case 'invalid-credential':
          DialogUtils.showMessage(
            context,
            title: "Error",
            message: "Email or password is incorrect",
            posActionTitle: "Retry",
            posAction: () {},
          );
          break;

        case 'user-not-found':
          DialogUtils.showMessage(
            context,
            title: "Error",
            message: "User not found",
            posActionTitle: "Retry",
            posAction: () {},
          );
          break;

        default:
          DialogUtils.showMessage(
            context,
            title: "Error",
            message: "Login failed",
            negActionTitle: "Try Again",
            negAction: () {},
          );
      }
      return;
    }

    DialogUtils.showMessage(
      context,
      title: "Login",
      message: "Login successful",
      posActionTitle: "Ok",
      posAction: () {
        Navigator.pushReplacementNamed(context, RoutesManager.mainLayout);
      },
    );
  }


  void _onClick() {
    setState(() {
      secure = !secure;
    });
  }

// void loginWithGoogle() async {
//   UserCredential? userCredential =
//   await AuthService.signInWithGoogle();
//
//   if (!mounted) return;
//
//   if (userCredential == null) {
//     DialogUtils.showMessage(
//       context,
//       title: "Error",
//       message: "Login failed",
//     );
//     return;
//   }
//
//   Navigator.pushReplacementNamed(
//     context,
//     RoutesManager.mainLayout,
//   );
// }
}
