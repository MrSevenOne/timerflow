import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

final mainColor = Color(0xFF2ECC71);
final secondColor = Color(0xFF080930);
ThemeData lightTheme = ThemeData(
  colorScheme: ColorScheme.light(
    error: Colors.red,
  ),
  brightness: Brightness.light,
  primaryColor: mainColor,
  //scaffold color
  scaffoldBackgroundColor: Color(0xFFF8F8F8),
  shadowColor: Color(0xFF000000),
  cardColor: Color(0xFFF5F5F5),
  //APPBAR
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF8F8F8),
    elevation: 0.0,
    titleTextStyle: GoogleFonts.pridi(textStyle: TextStyle(color: secondColor,
    fontSize: 24.sp,
     
    ),)
  ),
  //CARD THEME
cardTheme: CardTheme(
  color: Colors.white,
  elevation: 3.0,
  margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
    shape: RoundedRectangleBorder(
      side: BorderSide(
        width: 0.60,
        color: const Color(0xFFF5F5F5),
      ),
      borderRadius: BorderRadius.circular(8),
    ),
),

  //ICONBUTTON
  iconButtonTheme: IconButtonThemeData(
  style: ButtonStyle(
    foregroundColor: WidgetStateProperty.all(secondColor), // Icon rangi
    backgroundColor: WidgetStateProperty.all(Colors.transparent), // Orqa fon
    overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
      if (states.contains(WidgetState.pressed)) {
        // ignore: deprecated_member_use
        return secondColor.withOpacity(0.1); // Bosilganda fon rangi
      }
      return null;
    }),
    padding: WidgetStateProperty.all(EdgeInsets.all(8.0)), // Ichki bo‘sh joy
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
    ),
  ),
),
//DIALOG THEME
dialogTheme: DialogTheme(
  backgroundColor: Colors.white, // Dialog fon rangi
  elevation: 4.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.r), // Yumaloqlik
  ),
  titleTextStyle: TextStyle(
    color: secondColor,
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
  ),
  contentTextStyle: TextStyle(
    color: secondColor,
    fontSize: 14.sp,
  ),
),
 // Date Range Picker Theme
  datePickerTheme: DatePickerThemeData(
    backgroundColor: Colors.white,
    dividerColor: Colors.red
  ),


  //DRAWER
 drawerTheme: DrawerThemeData(
  backgroundColor: Colors.white, // Drawerning ochilgandagi foni
  // ignore: deprecated_member_use
  scrimColor: Colors.black.withOpacity(0.5), // Drawer ochilganda qora fon orqada
  elevation: 4.0,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(16.r),
      bottomRight: Radius.circular(16.r),
    ),
  ),
),

listTileTheme: ListTileThemeData(
  iconColor: secondColor,
  textColor: secondColor,
),


  //TEXTFIELD 
 inputDecorationTheme: InputDecorationTheme(
  // Hint ko‘rinishi (textfield bo‘sh bo‘lsa)
  hintStyle: TextStyle(color: Colors.grey[600]),

  // Label ko‘rinishi (textfield bo‘sh, fokuslanmagan bo‘lsa)
  labelStyle: TextStyle(color: Colors.grey[700]),

  // Label ko‘tarilgan holati (textfield fokuslangan yoki to‘ldirilgan bo‘lsa)
  floatingLabelStyle: TextStyle(color: mainColor, fontWeight: FontWeight.w600),

  filled: true,
  fillColor: Colors.white,

  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(color: Colors.grey),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(color: mainColor, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(color: Colors.red, width: 1.5),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.r),
    borderSide: BorderSide(color: Colors.red, width: 2),
  ),
  errorStyle: TextStyle(color: Colors.red, fontSize: 12.sp),
),
//TEXT
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
  labelMedium:TextStyle(
    color: Colors.grey[800],
  ),
),
//ELEVATIONBUTTON
 elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: mainColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      textStyle: GoogleFonts.pridi(textStyle: TextStyle(
        fontSize: 16.sp,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),),
    ),
  ),
  //BOTTONNAVIGATORBAR
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
  backgroundColor: Colors.white,
  selectedItemColor: mainColor,
  elevation: 2.0,
  unselectedItemColor: Colors.grey[600],
  selectedLabelStyle: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 12.sp,
  ),
  unselectedLabelStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 12.sp,
  ),
  showUnselectedLabels: true,
  type: BottomNavigationBarType.fixed,
),
//FLOATINGACTIONBUTTON
 floatingActionButtonTheme:  FloatingActionButtonThemeData(
  backgroundColor: mainColor, // Tugma rangi
  foregroundColor: Colors.white, // Ikonka rangi
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12), // Tugma chetini yumshatish
  ),
  elevation: 2.0, // Soya darajas
),

//TABBATVIEW
tabBarTheme: TabBarTheme(
  labelColor: mainColor,
  unselectedLabelColor: Colors.grey[600],
  labelStyle: TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
  ),
  unselectedLabelStyle: TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
  ),
  indicator: UnderlineTabIndicator(
    borderSide: BorderSide(
      color: mainColor,
      width: 2,
    ),
  ),
),

);
