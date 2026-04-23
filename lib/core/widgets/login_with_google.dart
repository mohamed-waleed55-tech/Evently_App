import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../resources/colors/colors_manager.dart';
import '../resources/images/images_manager.dart';



class LoginWithGoogle extends StatelessWidget {
  const LoginWithGoogle({super.key,required this.onClick,required this.title});
  final VoidCallback onClick;

  final String title;
  @override
  Widget build(BuildContext context) {
    return
      InkWell(
        onTap: (){
          onClick();
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: REdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: ColorsManager.blue,width: 1)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImagesManager.google),
              Text(title,style: Theme.of(context).textTheme.labelMedium,),
            ],
          ),
        ),
      );
  }
}
