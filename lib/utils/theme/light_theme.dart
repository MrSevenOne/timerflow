import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light, // Ilovaning umumiy yorqin rejimi

  // 🌈 PRIMARY COLOR - asosiy brend rangi
  primaryColor: const Color(0xFF0066CC),
  // 🔹 primaryColor ishlatiladi: asosiy tugmalar, linklar va faollashtirilgan elementlar

  // 🌈 COLOR SCHEME - batafsil ranglar
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF0066CC),
    // 🔹 Aktiv elementlar (tugmalar, indikatorlar) uchun

    secondary: Color(0xFF00A3FF),
    // 🔹 Sahifa fonlari, umumiy background

    surface: Colors.white,
    // 🔹 Kartalar, dialoglar, bottom sheet fonlari uchun

    error: Color(0xFFE53935),
    // 🔹 Xatolik yoki noto‘g‘ri input holatlari uchun

    shadow: Color(0xFFA9A9A9),
  ),

  // 🧱 Scaffold fon rangi
  scaffoldBackgroundColor: const Color(0xFFF8F9FA),
  // 🔹 Umumiy ekran fonlari

  // ✨ AppBar uslubi
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    // 🔹 AppBar fon rangi

    elevation: 1,
    // 🔹 AppBar soyasi

    centerTitle: true,
    // 🔹 Sarlavha markazlashtiriladi

    iconTheme: const IconThemeData(
      color: Color(0xFF0066CC),
      // 🔹 AppBar iconlari rangi
    ),

    titleTextStyle: GoogleFonts.poppins(
      color: const Color(0xFF1E1E1E),
      // 🔹 AppBar sarlavha matni rangi

      fontSize: 18,
      // 🔹 Sarlavha o‘lchami

      fontWeight: FontWeight.w600,
      // 🔹 Sarlavha qalinligi
    ),
  ),

  // 🔘 Iconlar uchun rang
  iconTheme: const IconThemeData(
    color: Color(0xFF1E1E1E),
    // 🔹 Standart ikonka rangi (matn va UI bilan kontrastda)
  ),

  // 💬 Matn uslublari
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
      color: const Color(0xFF1E1E1E),
      // 🔹 Katta matnlar, sahifa sarlavhalari uchun

      fontSize: 28,
      fontWeight: FontWeight.w500,
    ),
    displayMedium: GoogleFonts.poppins(
      color: const Color(0xFF1E1E1E),
      // 🔹 O‘rta sarlavhalar yoki kartalardagi matnlar

      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: const Color(0xFF707B81),
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 1.5,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: const Color(0xFF5F6368),
      // 🔹 Ikkinchi darajali matn, yordamchi info

      fontSize: 14,
    ),
    labelLarge: GoogleFonts.poppins(
      color: Colors.white,
      // 🔹 Button ichidagi matn rangi

      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
  ),

  // 🔘 Button uslublari
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF5B9EE1),
      // 🔹 Tugma asosiy rangi

      foregroundColor: Colors.white,
      // 🔹 Tugma matn rangi

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        // 🔹 Tugma radiusi
      ),

      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
      // 🔹 Tugma paddingi

      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  ),

  // 🧩 Input maydonlari
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.aBeeZee(
      textStyle: const TextStyle(
        color: Color(0xFF707B81),
        fontSize: 14,
      ),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFFE9EDEF)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color(0xFF5B9EE1), width: 2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Colors.red, width: 2),
    ),
  ),

  // ⚪ Divider (bo‘linmalar)
  dividerColor: const Color(0xFFE0E0E0),
  // 🔹 Chiziqlar, bo‘linmalar uchun rang

  // 📦 Card uslubi

);
