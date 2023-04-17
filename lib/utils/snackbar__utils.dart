import 'package:flutter/material.dart';
import 'package:mcapp/utils/dimensions_utils.dart';
import 'package:mcapp/utils/rgb_utils.dart';
import 'package:mcapp/utils/navigator_key.dart';

class SnackBarUtils {
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
      {required String title, required bool isError}) {
    return ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.info_outline,
              color: RGB.white,
            ),
            const SizedBox(
              width: Dimensions.smSize,
            ),
            Expanded(
              child: Text(
                title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        backgroundColor: isError ? Colors.orange : Colors.green,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.smSize,
          horizontal: Dimensions.defaultSize,
        ),
      ),
    );
  }
}
