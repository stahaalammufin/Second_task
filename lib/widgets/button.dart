import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget{
  final String buttonText;
  final Function callback;

  const BottomButton({super.key, required this.buttonText, required this.callback});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){
        callback.call();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0335B4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(buttonText),
    );
  }
  
}