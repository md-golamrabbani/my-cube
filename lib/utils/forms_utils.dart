import 'package:flutter/material.dart';
import 'package:travel/utils/dimensions_utils.dart';
import 'package:travel/utils/rgb_utils.dart';
import 'package:unicons/unicons.dart';

final primaryBtn = ElevatedButton.styleFrom(
  backgroundColor: RGB.primary,
);
final secondaryBtn = ElevatedButton.styleFrom(
  backgroundColor: RGB.primary,
);
final primaryBtnRounded = ElevatedButton.styleFrom(
  backgroundColor: RGB.primary,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(Dimensions.defaultSize * 100),
  ),
);
final secondaryBtnRounded = ElevatedButton.styleFrom(
  backgroundColor: RGB.primary,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(Dimensions.defaultSize * 100),
  ),
);

class FormsUtils {
  static inputStyle({
    IconData? prefixIcon,
    IconData? suffixIcon,
    VoidCallback? suffixOnPressed,
    bool? passwordVisibility,
    required String hintText,
  }) {
    return InputDecoration(
      prefixIcon: prefixIcon != null
          ? Icon(
              prefixIcon,
              size: Dimensions.lgSize,
            )
          : null,
      suffixIcon: suffixOnPressed != null
          ? IconButton(
              onPressed: () {
                suffixOnPressed.call();
              },
              icon: passwordVisibility!
                  ? const Icon(
                      UniconsLine.eye,
                      color: RGB.lightDarker,
                    )
                  : const Icon(
                      UniconsLine.eye_slash,
                      color: RGB.lightDarker,
                    ),
            )
          : suffixIcon != null
              ? Icon(suffixIcon)
              : null,
      border: const OutlineInputBorder(
        borderSide: BorderSide(
          width: 1,
          color: RGB.lightDarker,
        ),
      ),
      hintText: hintText,
      fillColor: RGB.white,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusSize),
        borderSide: const BorderSide(
          color: RGB.muted,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusSize),
        borderSide: const BorderSide(
          color: RGB.muted,
          width: 1,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusSize),
        borderSide: const BorderSide(
          color: RGB.lightDarker,
          width: 1,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusSize),
        borderSide: const BorderSide(
          color: RGB.lightDarker,
          width: 1,
        ),
      ),
      contentPadding: const EdgeInsets.all(
        Dimensions.defaultSize / 1.25,
      ),
      counterText: '',
    );
  }
}
