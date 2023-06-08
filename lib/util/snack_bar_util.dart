import 'package:flutter/material.dart';

class SnackBarUtil extends SnackBar {
  const SnackBarUtil({required Widget content, Key? key})
      : super(content: content, key: key);

  SnackBarUtil.critical({
    Key? key,
    required String text,
  }) : super(
    content: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
    ),
    key: key,
    backgroundColor: const Color(0xFFB91C1C),
    duration: const Duration(milliseconds: 2000),
    behavior: SnackBarBehavior.floating,
    elevation: 10,
    dismissDirection: DismissDirection.horizontal,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        4,
      ),
    ),
  );

}
