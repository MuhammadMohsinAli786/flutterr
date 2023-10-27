import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Button.dart';
import 'ColorPicker.dart';
import 'main.dart';
class CustomButton extends StatefulWidget {
  final int index;

  CustomButton(this.index);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  void playSound(int soundNumber) {
    AssetsAudioPlayer.newPlayer().open(
      Audio("assets/note$soundNumber.wav"),
      autoStart: true,
      showNotification: true,
    );
  }

  void showCustomizationDialog(BuildContext context) {
    final buttonProvider = Provider.of<ButtonProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        Button button = buttonProvider.buttons[widget.index];

        Color selectedColor = button.buttonColor;
        int selectedSoundNumber = button.buttonSoundNumber;
        double selectedHeight = button.buttonHeight;
        double selectedWidth = button.buttonWidth;

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Customize Button"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Button Color"),
                  ColorPicker(selectedColor, (color) {
                    setState(() {
                      selectedColor = color;
                    });
                  }),
                  Text("Button Sound"),
                  DropdownButton<int>(
                    value: selectedSoundNumber,
                    items: List.generate(9, (i) {
                      return DropdownMenuItem(
                        value: i + 1,
                        child: Text("Sound ${i + 1}"),
                      );
                    }),
                    onChanged: (int? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedSoundNumber = newValue;
                        });
                      }
                    },
                  ),
                  Text("Button Height"),
                  Slider(
                    value: selectedHeight,
                    min: 10,
                    max: MediaQuery.of(context).size.height / 3,
                    onChanged: (newValue) {
                      setState(() {
                        selectedHeight = newValue;
                      });
                    },
                  ),
                  Text("Button Width"),
                  Slider(
                    value: selectedWidth,
                    min: 10,
                    max: MediaQuery.of(context).size.width / 3,
                    onChanged: (newValue) {
                      setState(() {
                        selectedWidth = newValue;
                      });
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("Save"),
                  onPressed: () {
                    buttonProvider.updateButtonProperties(
                      widget.index,
                      selectedColor,
                      selectedSoundNumber,
                      selectedHeight,
                      selectedWidth,
                    );
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttonProvider = Provider.of<ButtonProvider>(context, listen: true);
    Button button = buttonProvider.buttons[widget.index];

    double buttonWidth = MediaQuery.of(context).size.width / 3;
    double buttonHeight = MediaQuery.of(context).size.height / 3;

    return GestureDetector(
      onLongPress: () {
        showCustomizationDialog(context);
      },
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: button.buttonColor,
          minimumSize: Size(buttonWidth, buttonHeight),
        ),
        onPressed: () {
          playSound(button.buttonSoundNumber);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Playing Sound ${button.buttonSoundNumber}'),
            duration: Duration(milliseconds: 50),
          ));
        },
        child: Text('Sound ${button.buttonSoundNumber}'),
      ),
    );
  }
}