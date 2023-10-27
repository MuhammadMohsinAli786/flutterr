import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Button.dart';
import 'XylophonePage.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ButtonProvider(),
      child: XylophoneApp(),
    ),
  );
}

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: XylophonePage(),
    );
  }
}

