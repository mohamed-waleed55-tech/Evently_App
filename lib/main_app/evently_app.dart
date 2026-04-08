import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/theme/theme_manager.dart';
import '../core/resources/routes/routesManager.dart';

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(383, 841),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child)=> MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesManager.mainLayout ,
        onGenerateRoute:RoutesManager.router ,
        theme: ThemeManager.light,
        darkTheme: ThemeManager.dark,
        themeMode: ThemeMode.light,)
    );
  }
}
