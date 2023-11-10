import 'package:flutter/material.dart';
import 'package:bottle_spin_game/HomeScreen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 15), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/Splash Screen.gif', // replace with your splash background image asset
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  color: Colors.white,
                ),
                SizedBox(height: 20),
                Text(
                  'Loading...',
                  style: TextStyle(color: Colors.white,fontSize: 40,fontStyle: FontStyle.italic),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
