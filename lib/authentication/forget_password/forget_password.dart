import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/core/resources/images/images_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/dialog.dart';
import '../../firebase_service/firestore/auth_service.dart';
import '../../l10n/app_localizations.dart';
import '../widgets/custom_text_form_field.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late TextEditingController emailController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }
  GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.forget_password),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.h),

                Image.asset(
                  ImagesManager.forgetPassword,
                  height: 200.h,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: 16.h),

                CustomTextFormField(
                  label: AppLocalizations.of(context)!.email,
                  prefixIcon: Icons.email,
                  controller: emailController,
                ),

                SizedBox(height: 16.h),

                CustomElevatedButton(
                  title: AppLocalizations.of(context)!.reset_password,
                  onClick: resetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );}

  void resetPassword() async {
    if(!formKey.currentState!.validate()) return;


    DialogUtils.showLoadingDialog(context, "Sending reset email...");

    final result = await AuthService.resetPassword(
      emailController.text.trim(),
    );

    if (!context.mounted) return;

    DialogUtils.hideDialog(context);

    if (result != null) {
      DialogUtils.showMessage(
        context,
        title: "Error",
        message: result,
        posActionTitle: "Ok",
        posAction: () {
          resetPassword();
        },
      );
      return;
    }

    DialogUtils.showMessage(
      context,
      title: "Success",
      message: "Password reset email sent. Check your inbox.",
      posActionTitle: "Ok",
      posAction: () {

      },
    );
  }
}
