import 'package:flutter/material.dart';

class BottomSheetUtil {
  static Future<dynamic> showBottomSheet(
    BuildContext context,
    Widget bottomSheet, {
    double elevation = 1,
  }) {
    return showModalBottomSheet<dynamic>(
      context: context,
      backgroundColor: Colors.white,
      elevation: elevation,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(
            10,
          ),
        ),
      ),
      builder: (BuildContext buildContext) {
        return bottomSheet;
      },
    );
  }
}
