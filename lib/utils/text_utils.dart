import 'package:flutter/material.dart';
import 'package:travel/utils/dimensions_utils.dart';
import 'package:travel/utils/rgb_utils.dart';

class TextStyles {
  static const defaultStyle = TextStyle(
    color: RGB.white,
    fontSize: Dimensions.defaultSize,
  );

  static const smallLightStyle = TextStyle(
    color: RGB.white,
    fontSize: Dimensions.smSize,
  );

  static const darkStyle = TextStyle(
    color: RGB.lightDarker,
    fontSize: Dimensions.defaultSize,
  );

  static const titleDarkStyle = TextStyle(
    color: RGB.lightDarker,
    fontSize: Dimensions.defaultSize + 2,
    fontWeight: FontWeight.w600,
  );
}
