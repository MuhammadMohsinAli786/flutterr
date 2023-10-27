import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Button.dart';
import 'CustomButton.dart';
class XylophonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.redAccent,
        title: Text('XyloPhone', style: TextStyle(fontSize: 40, color: Colors.white)),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text("Reset"),
                  value: "reset",
                ),
              ];
            },
            onSelected: (value) {
              if (value == "reset") {
                Provider.of<ButtonProvider>(context, listen: false).resetButtonProperties();
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: [
          Column(
            children: List<Widget>.generate(3, (rowIndex) {
              return Row(
                children: List<Widget>.generate(3, (colIndex) {
                  final index = rowIndex * 3 + colIndex;
                  return Expanded(
                    child: CustomButton(index),
                  );
                }),
              );
            }),
          ),
        ],
      ),
    );
  }
}