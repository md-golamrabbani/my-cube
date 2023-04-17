import 'package:flutter/material.dart';
import 'package:mcapp/utils/dimensions_utils.dart';
import 'package:mcapp/utils/rgb_utils.dart';

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
