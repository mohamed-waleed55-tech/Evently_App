import 'package:evently/core/app_validators/app_validators.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/features/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/features/authentication/widgets/custom_text_button.dart';
import 'package:evently/features/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isSecure;
  final bool isLoading;
  final VoidCallback onTogglePassword;
  final VoidCallback onSubmit;

  const LoginForm({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isSecure,
    required this.isLoading,
    required this.onTogglePassword,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            controller: emailController,
            validator: AppValidators.validateEmail,
            label: loc.email,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
          ),

          SizedBox(height: 20.h),
          
          CustomTextFormField(
            controller: passwordController,
            validator: AppValidators.validatePassword,
            label: loc.password,
            prefixIcon: Icons.lock_outline,
            isSecure: isSecure,
            suffixIcon: isSecure
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            onClick: onTogglePassword,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
          ),
          SizedBox(height: 8.h),
          Align(
            alignment: Alignment.centerRight,
            child: CustomTextButton(
              title: loc.forget_password,
              onClick: () {
                Navigator.pushNamed(
                  context,
                  RoutesManager.forgetPassword,
                );
              },
            ),
          ),
          SizedBox(height: 24.h),
          CustomElevatedButton(
            title: isLoading ? "Loading..." : loc.login,
            onClick: isLoading ? null : onSubmit,
          ),
        ],
      ),
    );
  }
}