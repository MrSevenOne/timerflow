import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final mainColor = Color(0xFF2ECC71);
final secondColor = Color(0xFF080930);

ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(error: Colors.red),
  brightness: Brightness.light,
  primaryColor: mainColor,
  scaffoldBackgroundColor: Color(0xFFF8F8F8),
  shadowColor: Color(0xFF000000),
  cardColor: Color(0xFFF5F5F5),

  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF8F8F8),
    elevation: 0.0,
    titleTextStyle: GoogleFonts.pridi(
      textStyle: TextStyle(
        color: secondColor,
        fontSize: 24,
      ),
    ),
  ),

  cardTheme: CardTheme(
    color: Colors.white,
    elevation: 3.0,
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(
      side: BorderSide(width: 0.6, color: Color(0xFFF5F5F5)),
      borderRadius: BorderRadius.circular(8),
    ),
  ),

  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(secondColor),
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
        if (states.contains(WidgetState.pressed)) {
          return secondColor.withOpacity(0.1);
        }
        return null;
      }),
      padding: WidgetStateProperty.all(EdgeInsets.all(8.0)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
  ),

  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    elevation: 4.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    titleTextStyle: TextStyle(
      color: secondColor,
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
    contentTextStyle: TextStyle(
      color: secondColor,
      fontSize: 14,
    ),
  ),

  datePickerTheme: DatePickerThemeData(
    backgroundColor: Colors.white,
    dividerColor: Colors.red,
  ),

  drawerTheme: DrawerThemeData(
    backgroundColor: Colors.white,
    scrimColor: Colors.black.withOpacity(0.5),
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
    ),
  ),

  listTileTheme: ListTileThemeData(
    iconColor: secondColor,
    textColor: secondColor,
  ),

  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey[600]),
    labelStyle: TextStyle(color: Colors.grey[700]),
    floatingLabelStyle: TextStyle(
      color: mainColor,
      fontWeight: FontWeight.w600,
    ),
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: mainColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.red, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.red, width: 2),
    ),
    errorStyle: TextStyle(color: Colors.red, fontSize: 12),
  ),

  textTheme: TextTheme(
    headlineMedium: TextStyle(
      color: secondColor,
      fontWeight: FontWeight.w500,
    ),
    titleLarge: TextStyle(
      color: secondColor,
      fontSize: 20,
      fontWeight: FontWeight.w400,
    ),
    titleMedium: TextStyle(
      color: secondColor,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: TextStyle(
      color: secondColor,
    ),
    labelMedium: TextStyle(
      color: Colors.grey[800],
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: mainColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      textStyle: GoogleFonts.pridi(
        textStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: mainColor,
    elevation: 2.0,
    unselectedItemColor: Colors.grey[600],
    selectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,
  ),

  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: mainColor,
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 2.0,
  ),

  tabBarTheme: TabBarTheme(
    labelColor: mainColor,
    unselectedLabelColor: Colors.grey[600],
    labelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    indicator: UnderlineTabIndicator(
      borderSide: BorderSide(
        color: mainColor,
        width: 2,
      ),
    ),
  ),
);
