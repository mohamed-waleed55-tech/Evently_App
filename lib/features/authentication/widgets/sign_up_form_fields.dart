
import 'package:evently/core/app_validators/app_validators.dart';
import 'package:evently/features/authentication/signUp/cubit/sign_up_cubit.dart';
import 'package:evently/features/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController rePasswordController;
  final RegisterCubit cubit;
  final AppLocalizations loc;

  const SignUpFormFields({super.key, 
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.rePasswordController,
    required this.cubit,
    required this.loc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: nameController,
          validator: AppValidators.validateName,
          label: loc.name,
          prefixIcon: Icons.person_outline_rounded,
          keyboardType: TextInputType.name,
          autofillHints: const [AutofillHints.name],
        ),
        SizedBox(height: 16.h),
        CustomTextFormField(
          controller: emailController,
          validator: AppValidators.validateEmail,
          label: loc.email,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
        ),
        SizedBox(height: 16.h),
        CustomTextFormField(
          controller: passwordController,
          validator: AppValidators.validatePassword,
          label: loc.password,
          prefixIcon: Icons.lock_outline_rounded,
          isSecure: cubit.secure,
          suffixIcon: cubit.secure
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          onClick: cubit.togglePassword,
          keyboardType: TextInputType.visiblePassword,
          autofillHints: const [AutofillHints.newPassword],
        ),
        SizedBox(height: 16.h),
        CustomTextFormField(
          controller: rePasswordController,
          validator: (value) => AppValidators.validateRePassword(
            value,
            passwordController.text,
          ),
          label: loc.re_password,
          prefixIcon: Icons.lock_reset_rounded,
          isSecure: cubit.resecure,
          suffixIcon: cubit.resecure
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          onClick: cubit.toggleRePassword,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}

