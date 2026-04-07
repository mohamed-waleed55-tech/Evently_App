import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/authentication/widgets/custom_text_button.dart';
import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/authentication/widgets/login_with_google.dart';
import 'package:evently/authentication/widgets/or_shape.dart';
import 'package:evently/resources/colors/colors_manager.dart';
import 'package:evently/resources/images/images_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool secure = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding:  REdgeInsets.all(16.0),
                child: Image.asset(ImagesManager.eventlyLogo),
              ),
              SizedBox(height: 24.h),
              CustomTextFormField(label: "Email", prefixIcon: Icons.email),
              SizedBox(height: 16.h),
              CustomTextFormField(
                label: "Password",
                prefixIcon: Icons.lock,
                suffixIcon: secure ? Icons.visibility_off : Icons.visibility,
                isSecure: secure,
                onClick: _onClick,
              ),

              Align(
                alignment: Alignment.centerRight,
                child: CustomTextButton(title: "Forget Password?"),
              ),
              SizedBox(height: 24.h),

              CustomElevatedButton(title: "Sign-In"),
              SizedBox(height: 24.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t Have Account ? ",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  CustomTextButton(title: "Create Account"),
                ],
              ),
              OrShape(),
              SizedBox(height: 24.h),
              LoginWithGoogle(),
            ],
          ),
        ),
      ),
    );
  }

  void _onClick() {
    setState(() {
      secure = !secure;
    });
  }
}
