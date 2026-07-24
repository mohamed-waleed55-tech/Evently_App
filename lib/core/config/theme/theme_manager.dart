import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  static const Color primaryLight = Color(0xFF0F766E); 
  static const Color primaryDark = Color(0xFF14B8A6);  
  
  static const Color lightBg = Color(0xFFF8FAFC);
  static const Color darkBg = Color(0xFF0F172A);
  static const Color error = Color(0xFFE11D48);

  static final ThemeData lightTheme = _buildTheme(
    brightness: Brightness.light,
    primary: primaryLight,
    background: lightBg,
    onBackground: const Color(0xFF0F172A),
  );

  static final ThemeData darkTheme = _buildTheme(
    brightness: Brightness.dark,
    primary: primaryDark,
    background: darkBg,
    onBackground: const Color(0xFFF8FAFC),
  );

  static ThemeData _buildTheme({
    required Brightness brightness,
    required Color primary,
    required Color background,
    required Color onBackground,
  }) {
    final bool isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: brightness,
        primary: primary,
        surface: background,
        error: error,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        centerTitle: true,
        elevation: 0,
        scrolledUnderElevation: 0,
        iconTheme: IconThemeData(color: primary),
        titleTextStyle: GoogleFonts.plusJakartaSans(
          color: isDark ? Colors.white : primary,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: TextTheme(
        titleSmall: GoogleFonts.plusJakartaSans(
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
          color: primary,
        ),
        displaySmall: GoogleFonts.plusJakartaSans(
          color: onBackground,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        headlineMedium: GoogleFonts.plusJakartaSans(
          color: onBackground,
          fontWeight: FontWeight.w700,
          fontSize: 24.sp,
        ),
        bodyLarge: GoogleFonts.plusJakartaSans(
          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
          fontSize: 16.sp,
        ),
        bodySmall: GoogleFonts.plusJakartaSans(
          color: onBackground,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
        contentPadding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: primary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: error, width: 2),
        ),
        labelStyle: TextStyle(color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B)),
        hintStyle: TextStyle(color: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
          minimumSize: Size(double.infinity, 50.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 0,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primary,
        unselectedItemColor: isDark ? const Color(0xFF64748B) : const Color(0xFF94A3B8),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        backgroundColor: primary,
        foregroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
      ),
    );
  }
}