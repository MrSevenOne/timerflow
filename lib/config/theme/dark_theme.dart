import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// RANGLAR (asosiy ranglar qorong‘iga moslashtirildi)
final mainColor = Color(0xFF2ECC71); // yashil qoladi
final secondColor = Color(0xFFF1F1F1); // matn va ikonkalarga mos och rang

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    error: Colors.red,
  ),
  brightness: Brightness.dark,
  primaryColor: mainColor,

  scaffoldBackgroundColor: const Color(0xFF121212),
  shadowColor: Colors.black87,
  cardColor: const Color(0xFF1E1E1E),

  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFF121212),
    elevation: 0.0,
    titleTextStyle: GoogleFonts.pridi(
      textStyle: TextStyle(
        color: secondColor,
        fontSize: 24,
      ),
    ),
    iconTheme: IconThemeData(color: secondColor),
  ),

  cardTheme: CardTheme(
    color: const Color(0xFF1E1E1E),
    elevation: 3.0,
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(
      side: const BorderSide(width: 0.6, color: Color(0xFF2A2A2A)),
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
      padding: WidgetStateProperty.all(const EdgeInsets.all(8.0)),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
  ),

  dialogTheme: DialogTheme(
    backgroundColor: const Color(0xFF1E1E1E),
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
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
    backgroundColor: const Color(0xFF1E1E1E),
    dividerColor: Colors.red,
  ),

  drawerTheme: DrawerThemeData(
    backgroundColor: const Color(0xFF1E1E1E),
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
    hintStyle: TextStyle(color: Colors.grey[400]),
    labelStyle: TextStyle(color: Colors.grey[300]),
    floatingLabelStyle: TextStyle(color: mainColor, fontWeight: FontWeight.w600),
    filled: true,
    fillColor: const Color(0xFF1A1A1A),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.grey[700]!),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: mainColor, width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.red, width: 1.5),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.red, width: 2),
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
      color: Colors.grey[300],
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: mainColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
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
    backgroundColor: const Color(0xFF1E1E1E),
    selectedItemColor: mainColor,
    unselectedItemColor: Colors.grey[500],
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
    elevation: 2.0,
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
    unselectedLabelColor: Colors.grey[500],
    labelStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    unselectedLabelStyle: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(
        color: Color(0xFF2ECC71),
        width: 2,
      ),
    ),
  ),
);
