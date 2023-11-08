import 'package:flutter/material.dart';

import '../Constant.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color colors;
  final VoidCallback onpress;

  MyButton({
    super.key,
    required this.title,
    this.colors = Colors.green,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: InkWell(
          onTap: onpress,
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: colors,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Transform.translate(
              offset: Offset(0, -5), // Adjust this value to control the lift
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 30, color: whiteColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
