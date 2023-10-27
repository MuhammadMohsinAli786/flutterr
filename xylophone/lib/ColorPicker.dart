import 'package:flutter/material.dart';
class ColorPicker extends StatefulWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;

  ColorPicker(this.selectedColor, this.onColorChanged);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color selectedColor;
  double redValue = 0;
  double greenValue = 0;
  double blueValue = 0;

  @override
  void initState() {
    super.initState();
    selectedColor = widget.selectedColor;
    redValue = selectedColor.red.toDouble();
    greenValue = selectedColor.green.toDouble();
    blueValue = selectedColor.blue.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Container(
            width: 30,
            height: 30,
            color: Color.fromARGB(
                255, redValue.toInt(), greenValue.toInt(), blueValue.toInt()),
          ),
          Expanded(
            child: Slider(
              value: redValue,
              onChanged: (value) {
                setState(() {
                  redValue = value;
                  updateColor();
                });
              },
              min: 0,
              max: 255,
            ),
          ),
          Expanded(
            child: Slider(
              value: greenValue,
              onChanged: (value) {
                setState(() {
                  greenValue = value;
                  updateColor();
                });
              },
              min: 0,
              max: 255,
            ),
          ),
          Expanded(
            child: Slider(
              value: blueValue,
              onChanged: (value) {
                setState(() {
                  blueValue = value;
                  updateColor();
                });
              },
              min: 0,
              max: 255,
            ),)
        ]
    );
  }

  void updateColor() {
    final newColor = Color.fromARGB(
      255,
      redValue.toInt(),
      greenValue.toInt(),
      blueValue.toInt(),
    );
    widget.onColorChanged(newColor);
  }
}