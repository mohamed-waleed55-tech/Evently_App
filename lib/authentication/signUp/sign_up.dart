import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/authentication/widgets/custom_text_button.dart';
import 'package:evently/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/core/resources/images/images_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool secure = true;
  bool resecure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Column(
        children: [
          Expanded(flex: 1, child: Image.asset(ImagesManager.logo)),
          Expanded(
            flex: 4,
            child: Padding(
              padding: REdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextFormField(label: "Name", prefixIcon: Icons.person),
                  SizedBox(height: 16.h),
                  CustomTextFormField(label: "Email", prefixIcon: Icons.email),
                  SizedBox(height: 16.h),

                  CustomTextFormField(
                    label: "Password",
                    prefixIcon: Icons.lock,
                    suffixIcon: secure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    isSecure: secure,
                    onClick: _onclick,
                  ),
                  SizedBox(height: 16.h),

                  CustomTextFormField(
                    label: "Re Password",
                    prefixIcon: Icons.lock,
                    suffixIcon: resecure
                        ? Icons.visibility_off
                        : Icons.visibility,
                    isSecure: resecure,
                    onClick: _reOnclick,
                  ),
                  SizedBox(height: 16.h),

                  CustomElevatedButton(title: "Create Account", onClick: () {}),
                  SizedBox(height: 16.h,),
                  CustomTextButton(title: "Sign-In",text: "Already Have Account ?",onClick: (){},)

                ],
              ),
            ),
          ),
        ],
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
}
