import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/resources/colors/colors_manager.dart';

class OrShape extends StatelessWidget {
  const OrShape({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Container(height: 1,color: ColorsManager.blue,margin: REdgeInsets.symmetric(horizontal: 16.w),)),
        Text("or",style: Theme.of(context).textTheme.labelSmall,)
        ,
        Expanded(child: Container(height: 1,color: ColorsManager.blue,margin: REdgeInsets.symmetric(horizontal: 16.w),))
      ],
    );
  }
}
