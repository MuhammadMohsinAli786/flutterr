import 'package:bottle_spin_game/Components/My_Button.dart';
import 'package:bottle_spin_game/SimpleSpin.dart';
import 'package:bottle_spin_game/Truth&Dare.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isOn = false; // Variable to track the on/off state
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
  }

  void launchWhatsApp() async {
    final phone = "+923130646071";  // Replace with the phone number you want to chat with
    final url = "https://wa.me/$phone";

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      // Handle the error if WhatsApp cannot be launched
      print("Could not launch WhatsApp");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text("Bottle Spin"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                launchWhatsApp(); // Call the function to open WhatsApp
              },
              child: Text("Contact us", style: TextStyle(color: Colors.white)),
            ),
            Switch(
              value: isOn,
              onChanged: (value) {
                setState(() {
                  isOn = value;
                  if (isOn) {
                    audioPlayer.play(AssetSource('assetes/note1.wav'));
                  } else {
                    audioPlayer.stop();
                  }
                });
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyButton(
                title: 'Simple Spin',
               // colors: Colors.green,
                onpress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SimpleSpin()));

                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyButton(
                title: 'Truth & Dare',
              //  colors: Colors.blue,
                onpress: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => TruthDare()));

                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}
