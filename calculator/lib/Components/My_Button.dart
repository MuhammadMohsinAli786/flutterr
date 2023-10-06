import 'package:flutter/material.dart';

import '../Constant.dart';

class MyButton extends StatelessWidget {
  final String title;
  final Color colors;
  final VoidCallback onpress;
  MyButton(
      {super.key,
      required this.title,
      this.colors = const Color(0xffa5a5a5),
      required this.onpress});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: InkWell(
          onTap: onpress,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors,
            ),
            child: Center(
                child: Text(
              title,
              style: const TextStyle(fontSize: 20, color: whiteColor),
            )),
          ),
        ),
      ),
    );
  }
}
