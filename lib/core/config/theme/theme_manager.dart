import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/colors/colors_manager.dart';


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
      displaySmall:TextStyle(
        color: ColorsManager.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ) ,
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
      bodyLarge: TextStyle(color: ColorsManager.gray, fontSize: 16.sp),
      bodySmall: GoogleFonts.inter(
        color: ColorsManager.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      ),
    ),
    iconTheme: IconThemeData(color: ColorsManager.gray),
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue),
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
        borderSide: BorderSide(color: ColorsManager.blue),
      ),

      labelStyle: TextStyle(color: ColorsManager.blue),
      hintStyle: TextStyle(color: ColorsManager.blue),


      prefixIconColor: ColorsManager.blue,
      suffixIconColor: ColorsManager.blue,
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
    tabBarTheme: TabBarThemeData(indicatorColor: Colors.transparent),
  );

  static final ThemeData dark = ThemeData(
    primaryColor: ColorsManager.blue,
    useMaterial3: false,

    scaffoldBackgroundColor: ColorsManager.black,

    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.black,
      centerTitle: true,
      titleTextStyle: GoogleFonts.roboto(
        color: ColorsManager.white,
        fontSize: 22.sp,
        fontWeight: FontWeight.normal,
      ),
      iconTheme: IconThemeData(color: ColorsManager.white),
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
        color: ColorsManager.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
      displaySmall:TextStyle(
        color: ColorsManager.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ) ,
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
      bodyLarge: TextStyle(color: ColorsManager.offWhite, fontSize: 16.sp),
      bodySmall: GoogleFonts.inter(
        color: ColorsManager.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      ),
    ),

    iconTheme: IconThemeData(color: ColorsManager.white),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorsManager.black,

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: ColorsManager.blue),
      ),

      labelStyle: TextStyle(color: ColorsManager.blue),
      hintStyle: TextStyle(color: ColorsManager.blue),

      prefixIconColor: ColorsManager.blue,
      suffixIconColor: ColorsManager.blue,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.blue,
        foregroundColor: ColorsManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: REdgeInsets.symmetric(vertical: 16),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorsManager.black,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: ColorsManager.blue,
      unselectedItemColor: ColorsManager.gray,
    ),

    bottomAppBarTheme: BottomAppBarThemeData(
      color: ColorsManager.black,
      shape: CircularNotchedRectangle(),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      shape: StadiumBorder(
        side: BorderSide(color: ColorsManager.white, width: 3),
      ),
      backgroundColor: ColorsManager.blue,
    ),

    tabBarTheme: TabBarThemeData(
      indicatorColor: ColorsManager.blue,
      labelColor: ColorsManager.white,
      unselectedLabelColor: ColorsManager.gray,
    ),
  );
}
