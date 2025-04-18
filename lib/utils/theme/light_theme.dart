import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final mainColor = Color(0xFF5B9EE1);
// ignore: non_constant_identifier_names
ThemeData LightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFFF8F9FA),
    
    brightness: Brightness.light,
    primaryColorLight: mainColor,
    primaryColor: mainColor,
    cardColor: Colors.white,
    appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFFF8F9FA),
        titleTextStyle: TextStyle(fontSize: 24.0, color: Colors.black)),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: Color(0xFF5B9EE1),
      ),
      headlineMedium: TextStyle(
        color: Color(0xFF0E1724),
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        color: Color(0xFF707B81),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      
      labelStyle: TextStyle(
        color: mainColor,
      ),

      hintStyle: TextStyle(color: Colors.grey[600]),
      
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey, width: 1.w),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(
            color: Color(0xFF5B9EE1), width: 2.w), // ko'rinadigan rang
      ),

      // Qo‘shiladi: textField faolligida borderni to‘g‘ri ko‘rsatish uchun
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.red, width: 2.w),
      ),

      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.red, width: 1.w),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 36),
        textStyle: TextStyle(
          fontSize: 20.sp,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: mainColor,
        foregroundColor: Colors.white, // Icon yoki text oq rangda bo'ladi
    ),
   dialogTheme: DialogTheme(
  
  backgroundColor: Colors.white,
  titleTextStyle: TextStyle(
    color: Color(0xFF0E1724),
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    
  ),
  contentTextStyle: TextStyle(
    color: Color(0xFF707B81),
    fontSize: 16.sp,
  ),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16.r),
  ),
  elevation: 4,
),
bottomNavigationBarTheme: BottomNavigationBarThemeData(
  backgroundColor: Colors.white,
  selectedItemColor: mainColor,
  unselectedItemColor: Color(0xFF707B81),
  selectedLabelStyle: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
  ),
  unselectedLabelStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
  ),
  type: BottomNavigationBarType.fixed,
  elevation: 8,
),
);
