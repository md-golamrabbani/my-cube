import 'package:flutter/material.dart';

class ColorSchemeTheme {
  static final Map<int, Color> primaryColorMap = {
    50: const Color(0xFFf5aaa3),
    100: const Color(0xFFf08075),
    200: const Color(0xFFed6a5e),
    300: const Color(0xFFeb5547),
    400: const Color(0xFFe84434),
    500: const Color(0xFFe62a19),
    600: const Color(0xFFcf2617),
    700: const Color(0xFFb82214),
    800: const Color(0xFFa11e12),
    900: const Color(0xFF8a190f),
  };

  static final MaterialColor primary = MaterialColor(
      primaryColorMap[400]!.value, ColorSchemeTheme.primaryColorMap);
}
