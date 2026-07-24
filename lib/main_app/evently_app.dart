import 'package:evently/core/config/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../core/resources/routes/routes_manager.dart';
import '../features/tabs/profile/provider/config_provider.dart';
import '../l10n/app_localizations.dart';

class PulseApp extends StatelessWidget {
  const PulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Consumer<ConfigProvider>(
          builder: (context, configProvider, _) {
            return MaterialApp(
              title: 'Pulse',
              debugShowCheckedModeBanner: false,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              locale: Locale(configProvider.currentLang),
              initialRoute: RoutesManager.authGate,
              onGenerateRoute: RoutesManager.router,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: configProvider.currentTheme,
            );
          },
        );
      },
    );
  }
}