import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/authentication/widgets/custom_text_button.dart';
import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/core/widgets/login_with_google.dart';
import 'package:evently/authentication/widgets/or_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/resources/images/images_manager.dart';

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
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFormField(
                      label: "Email",
                      prefixIcon: Icons.email,
                    ),
                    SizedBox(height: 16.h),
                    CustomTextFormField(
                      label: "Password",
                      prefixIcon: Icons.lock,
                      suffixIcon: secure
                          ? Icons.visibility_off
                          : Icons.visibility,
                      isSecure: secure,
                      onClick: _onClick,
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(title: "Forget Password?",onClick: (){},),
                    ),
                    SizedBox(height: 24.h),

                    CustomElevatedButton(title: "Sign-In", onClick: () {}),
                    SizedBox(height: 24.h),

                    CustomTextButton(title: "Create Account",text: "Don’t Have Account ? ",onClick: (){},),
                    OrShape(),
                    SizedBox(height: 24.h),
                    LoginWithGoogle(
                      title: " Login With Google",
                      onClick: () {},
                    ),
                  ],
                ),
              ),
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
