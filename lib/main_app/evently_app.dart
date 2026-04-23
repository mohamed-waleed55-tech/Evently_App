import 'package:evently/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import '../config/theme/theme_manager.dart';
import '../core/resources/routes/routes_manager.dart';
import '../l10n/app_localizations.dart';

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var configProvider=Provider.of<ConfigProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(383, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child)=> MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en'), // English
          Locale('ar'), // Arabic
        ],
        locale: Locale(configProvider.currentLang),
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesManager.authGate,
        onGenerateRoute:RoutesManager.router ,
        theme: ThemeManager.light,
        darkTheme: ThemeManager.dark,
        themeMode: Provider.of<ConfigProvider>(context).currentTheme,)
    );
  }
}
