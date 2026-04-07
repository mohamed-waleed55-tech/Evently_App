import 'package:evently/authentication/widgets/custom_elevated_button.dart';
import 'package:evently/core/resources/images/images_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
        centerTitle:true ,
      ),
      body: Padding(
        padding:  REdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(ImagesManager.forgetPassword),
            SizedBox(height: 16.h,),
            CustomElevatedButton(title: "Reset Password", onClick: (){})
          ],
        ),
      ),
    );
  }
}
