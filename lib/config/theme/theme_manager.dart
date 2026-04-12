import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/resources/colors/colors_manager.dart';

class ThemeManager {
  static final ThemeData light = ThemeData(
    primaryColor: ColorsManager.blue,
    useMaterial3: false,
    scaffoldBackgroundColor: ColorsManager.offWhite,
    appBarTheme: AppBarThemeData(
      backgroundColor: ColorsManager.offWhite,
      centerTitle: true,
      titleTextStyle: GoogleFonts.roboto(
        color: ColorsManager.blue,
        fontSize: 22.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
    textTheme: TextTheme(
      titleSmall: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
        color: ColorsManager.blue,
        decoration: TextDecoration.underline,
        decorationColor: ColorsManager.blue,
      ),
      labelSmall: GoogleFonts.inter(
        color: ColorsManager.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      titleMedium: TextStyle(
        color: ColorsManager.white,
        fontWeight: FontWeight.w600,
        fontSize: 20.sp,
      ),
      labelMedium: TextStyle(
        color: ColorsManager.blue,
        fontWeight: FontWeight.w600,
        fontSize: 20.sp,
      ),
      headlineSmall: GoogleFonts.inter(
        color: ColorsManager.white,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
      ),
      headlineMedium: GoogleFonts.inter(
        color: ColorsManager.white,
        fontWeight: FontWeight.w700,
        fontSize: 24.sp,
      ),
      bodyLarge: TextStyle(
        color: ColorsManager.gray,
        fontSize: 16.sp
      ),
      bodySmall: GoogleFonts.inter(
        color: ColorsManager.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700


      )
    ),
    iconTheme: IconThemeData(color: ColorsManager.gray),
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: ColorsManager.gray),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: ColorsManager.gray),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: ColorsManager.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: ColorsManager.red),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: ColorsManager.gray),
        ),

        labelStyle: TextStyle(color: ColorsManager.gray),
        hintStyle: TextStyle(color: ColorsManager.gray),

        prefixIconColor: ColorsManager.gray,
        suffixIconColor: ColorsManager.gray,
      ),
    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom()),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: REdgeInsets.symmetric(vertical: 16),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.white,
      unselectedItemColor: ColorsManager.white,
    ),
    bottomAppBarTheme: BottomAppBarThemeData(
      color: ColorsManager.blue,
      shape: CircularNotchedRectangle(),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: StadiumBorder(
        side: BorderSide(color: ColorsManager.white, width: 4),
      ),
      backgroundColor: ColorsManager.blue,
    ),
    tabBarTheme: TabBarThemeData(
      indicatorColor: Colors.transparent,
    )
  );

  static final ThemeData dark = ThemeData();
}
