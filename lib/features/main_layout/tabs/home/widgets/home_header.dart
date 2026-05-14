import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:evently/DM/userDM.dart';
import 'package:evently/core/resources/icons/icons_manager.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/features/main_layout/tabs/profile/provider/config_provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final configProvider = context.watch<ConfigProvider>();
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 48),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(26.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${loc.welcome_back} ✨",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    UserDM.currentUser?.name ?? "Guest",
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              _buildToggles(configProvider),
            ],
          ),

          SizedBox(height: 8.h),

          Row(
            children: [
              SvgPicture.asset(IconsManager.mapOutlined, color: Colors.white),
              SizedBox(width: 6.w),
              Text(
                "Cairo, Egypt",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontSize: 16.sp
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggles(ConfigProvider configProvider) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => configProvider.changeTheme(
            configProvider.isLight ? ThemeMode.dark : ThemeMode.light,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              configProvider.isLight
                  ? Icons.wb_sunny_outlined
                  : Icons.dark_mode_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
        const SizedBox(width: 12),

        GestureDetector(
          onTap: () => configProvider.changeLang(
            configProvider.isEnglish ? "ar" : "en",
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              configProvider.isEnglish ? "En" : "Ar",
              style: const TextStyle(
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}