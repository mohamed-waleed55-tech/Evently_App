import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../tabs/map/provider/location_map.dart';

class LocationSelectorWidget extends StatelessWidget {
  const LocationSelectorWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mapProvider = context.watch<LocationMapProvider>();

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: theme.primaryColor),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.location_on, color: theme.colorScheme.onPrimary),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                '${mapProvider.city}, ${mapProvider.country}',
                style: theme.textTheme.labelMedium?.copyWith(fontSize: 16.sp),
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16.r, color: theme.primaryColor),
          ],
        ),
      ),
    );
  }
}