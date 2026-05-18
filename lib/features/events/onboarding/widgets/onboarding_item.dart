import 'package:evently/DM/onboarding_DM.dart';
import 'package:evently/core/resources/images/images_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingItem extends StatelessWidget {
  const OnboardingItem({super.key,required this.onboardingDm});
  final OnboardingDm onboardingDm;

  @override

  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(onboardingDm.imgPath),
           SizedBox(height: 16.h,),
          Text(onboardingDm.title,style: Theme.of(context).textTheme.labelMedium,),
          SizedBox(height: 30.h,),
          Text(onboardingDm.desc,style: Theme.of(context).textTheme.displaySmall),

        ],
      ),
    );
  }
}
