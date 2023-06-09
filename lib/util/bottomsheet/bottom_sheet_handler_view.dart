import 'package:flutter/material.dart';

class BottomSheetHandlerView extends StatelessWidget {
  const BottomSheetHandlerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 50,
        child: Divider(
          thickness: 4,
          color: Color(0xFFDCDEE6),
        ),
      ),
    );
  }
}
