
import 'package:evently/features/tabs/profile/provider/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CompactToggles extends StatelessWidget {
  const CompactToggles({super.key});

  @override
  Widget build(BuildContext context) {
    final isLight = context.select<ConfigProvider, bool>((p) => p.isLight);
    final isEnglish = context.select<ConfigProvider, bool>((p) => p.isEnglish);
    final configProvider = context.read<ConfigProvider>();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Dark / Light Toggle
        IconButton(
          onPressed: () => configProvider.changeTheme(
            isLight ? ThemeMode.dark : ThemeMode.light,
          ),
          style: IconButton.styleFrom(
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            minimumSize: Size(38.r, 38.r),
            padding: EdgeInsets.zero,
          ),
          icon: Icon(
            isLight ? Icons.wb_sunny_rounded : Icons.nightlight_round,
            color: Colors.white,
            size: 18.sp,
          ),
        ),
        SizedBox(width: 8.w),
        // Language Button
        InkWell(
          borderRadius: BorderRadius.circular(12.r),
          onTap: () => configProvider.changeLang(
            isEnglish ? "ar" : "en",
          ),
          child: Container(
            padding: REdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Text(
              isEnglish ? "EN" : "AR",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 12.sp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}