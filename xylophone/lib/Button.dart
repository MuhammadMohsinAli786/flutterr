import 'package:flutter/material.dart';
import 'dart:math' as math;
class ButtonProvider with ChangeNotifier {
  List<Button> buttons = List.generate(
    9,
        (index) => Button(
      buttonColor: _generateRandomColor(),
      buttonSoundNumber: index + 1,
      // buttonSize: 50.0,
      buttonHeight: 10.0, // Default height
      buttonWidth: 100.0, // Default width
    ),
  );

  void updateButtonProperties(
      int index, Color color, int soundNumber, double height, double width) {
    double size = height * width; // Calculate size based on height and width
    buttons[index] = Button(
      buttonColor: color,
      buttonSoundNumber: soundNumber,
      //buttonSize: size,
      buttonHeight: height,
      buttonWidth: width,
    );
    notifyListeners();
  }

  void resetButtonProperties() {
    for (int i = 0; i < buttons.length; i++) {
      buttons[i] = Button(
        buttonColor: _generateRandomColor(),
        buttonSoundNumber: i + 1,
        // buttonSize: 50.0,
        buttonHeight: 10.0, // Default height
        buttonWidth: 100.0, // Default width
      );
    }
    notifyListeners();
  }

  static Color _generateRandomColor() {
    return Color.fromARGB(
      255,
      _generateRandomValue(),
      _generateRandomValue(),
      _generateRandomValue(),
    );
  }

  static int _generateRandomValue() {
    return 40 + (math.Random().nextDouble() * 215).toInt();
  }
}

class Button {
  Color buttonColor;
  int buttonSoundNumber;
  double buttonHeight;
  double buttonWidth;

  Button({
    required this.buttonColor,
    required this.buttonSoundNumber,
    required this.buttonHeight,
    required this.buttonWidth,
  });
}