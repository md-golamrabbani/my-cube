import 'package:flutter/material.dart';
import 'package:travel/utils/dimensions_utils.dart';
import 'package:travel/utils/rgb_utils.dart';

class CustomStyle {
  static TextStyle textStyle = const TextStyle(
    color: RGB.lightDarker,
    fontSize: Dimensions.defaultSize,
  );
  static RoundedRectangleBorder modalShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(
        Dimensions.lgSize,
      ),
      topRight: Radius.circular(
        Dimensions.lgSize,
      ),
    ),
  );
}
