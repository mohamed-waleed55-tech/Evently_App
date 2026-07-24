import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class OrShape extends StatelessWidget {
  const OrShape({super.key});

  @override
  Widget build(BuildContext context) {
      final theme =Theme.of(context).colorScheme;

    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: Container(height: 1,color: theme.primary,margin: REdgeInsets.symmetric(horizontal: 16.w),)),
        Text("or",style: Theme.of(context).textTheme.labelSmall,)
        ,
        Expanded(child: Container(height: 1,color: theme.primary,margin: REdgeInsets.symmetric(horizontal: 16.w),))
      ],
    );
  }
}
