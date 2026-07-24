import 'package:evently/DM/userDM.dart';
import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/core/resources/routes/routes_manager.dart';
import 'package:evently/core/utils/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../core/firebase_service/firestore/auth_service.dart';
import '../../../../../l10n/app_localizations.dart';
import '../provider/config_provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<String> languages = ["English", "Arabic"];
  final List<String> modes = ["Light", "Dark"];

  @override
  Widget build(BuildContext context) {
    final configProvider = Provider.of<ConfigProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final user = UserDM.currentUser;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // 1. Header with User Details using Primary Theme Color
          _buildProfileHeader(context, user, colorScheme),

          SizedBox(height: 24.h),

          // 2. Settings & Preferences Options
          Padding(
            padding: REdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.language,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 10.h),
                _buildDropdownCard(
                  context,
                  value: configProvider.isEnglish ? "English" : "Arabic",
                  items: languages,
                  icon: Icons.language_rounded,
                  onChanged: (newLang) {
                    if (newLang != null) {
                      configProvider.changeLang(
                        newLang == "English" ? "en" : "ar",
                      );
                    }
                  },
                ),

                SizedBox(height: 20.h),

                Text(
                  AppLocalizations.of(context)!.theme,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 10.h),
                _buildDropdownCard(
                  context,
                  value: configProvider.isLight ? "Light" : "Dark",
                  items: modes,
                  icon: configProvider.isLight
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                  onChanged: (themeMode) {
                    if (themeMode != null) {
                      configProvider.changeTheme(
                        themeMode == "Light"
                            ? ThemeMode.light
                            : ThemeMode.dark,
                      );
                    }
                  },
                ),

                SizedBox(height: 40.h),

                // 3. Logout Button (Using Error Color from ColorScheme)
                SizedBox(
                  width: double.infinity,
                  height: 52.h,
                  child: ElevatedButton.icon(
                    onPressed: _logout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.errorContainer.withOpacity(0.3),
                      foregroundColor: colorScheme.error,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r),
                        side: BorderSide(
                          color: colorScheme.error,
                          width: 1.5,
                        ),
                      ),
                    ),
                    icon: Icon(
                      Icons.logout_rounded,
                      color: colorScheme.error,
                    ),
                    label: Text(
                      AppLocalizations.of(context)!.logout,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Header Component using ColorScheme
  Widget _buildProfileHeader(
      BuildContext context, UserDM? user, ColorScheme colorScheme) {
    return Container(
      width: double.infinity,
      padding: REdgeInsets.fromLTRB(20, 50, 20, 30),
      decoration: BoxDecoration(
        color: colorScheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36.r),
          bottomRight: Radius.circular(36.r),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Avatar with Adaptive Colors
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 42.r,
                    backgroundColor: colorScheme.onPrimary,
                    child: CircleAvatar(
                      radius: 39.r,
                      backgroundColor: colorScheme.surface,
                      child: Text(
                        user?.name.isNotEmpty == true
                            ? user!.name[0].toUpperCase()
                            : "U",
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 16.r,
                    height: 16.r,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.surface,
                        width: 2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 16.w),
              // User Email and Name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user?.name ?? "User Name",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      user?.email ?? "user@email.com",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onPrimary.withOpacity(0.85),
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Dropdown Custom Widget mapped to ColorScheme
  Widget _buildDropdownCard(
    BuildContext context, {
    required String value,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      padding: REdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: colorScheme.primary.withOpacity(0.4),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: colorScheme.primary, size: 22.r),
          SizedBox(width: 12.w),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: colorScheme.primary,
                  size: 26.r,
                ),
                dropdownColor: colorScheme.surface,
                items: items.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _logout() async {
    DialogUtils.showMessage(
      context,
      message: "Are you sure you want to logout?",
      title: "Logout",
      posActionTitle: "Ok",
      negActionTitle: "Cancel",
      posAction: () async {
        await AuthService.logout();
        if (mounted) {
          Navigator.pushReplacementNamed(context, RoutesManager.signIn);
        }
      },
    );
  }
}