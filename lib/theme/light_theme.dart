import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travel/theme/color_scheme_theme.dart';
import 'package:travel/utils/dimensions_utils.dart';
import 'package:travel/utils/rgb_utils.dart';

class LightTheme {
  static var systemUI = SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: RGB.white,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: RGB.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // theme => 0 mean light || 1 mean dark
  // top
  static updateStatusBar(dynamic bgColor, dynamic themeType) {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: bgColor,
          statusBarBrightness:
              themeType == 0 ? Brightness.light : Brightness.dark,
          statusBarIconBrightness:
              themeType == 0 ? Brightness.light : Brightness.dark,
          systemNavigationBarIconBrightness:
              themeType == 0 ? Brightness.light : Brightness.dark,
        ),
      );
    }
  }

  // bottom
  static updateNavigationBar(dynamic bgColor, dynamic themeType) {
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: bgColor,
          systemNavigationBarIconBrightness:
              themeType == 0 ? Brightness.light : Brightness.dark,
          systemNavigationBarContrastEnforced: true,
          systemNavigationBarDividerColor: const Color(0x00000000),
        ),
      );
    }
  }

  // light theme
  static ThemeData lightThemeData = ThemeData(
    textTheme: GoogleFonts.poppinsTextTheme(),
    primaryColor: RGB.primary,
    primarySwatch: ColorSchemeTheme.primary,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
        elevation: 1,
        backgroundColor: RGB.white,
        foregroundColor: RGB.dark,
        titleTextStyle: TextStyle(
          fontSize: Dimensions.defaultSize + 2,
          color: RGB.dark,
        )),
    popupMenuTheme: PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          Dimensions.defaultSize,
        ),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.symmetric(
            vertical: Dimensions.smSize + 2,
            horizontal: Dimensions.defaultSize,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              Dimensions.radiusSize,
            ),
            side: const BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: RGB.brightWhite,
      shape: CircularNotchedRectangle(),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: RGB.brightWhite,
      selectedItemColor: RGB.primary,
      unselectedItemColor: RGB.dark,
    ),
  );
}
