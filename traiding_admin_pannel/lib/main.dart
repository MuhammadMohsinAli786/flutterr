import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VideoPlayerController? _videoController;
  AudioPlayer _audioPlayer = AudioPlayer();
  String _webViewUrl = 'https://www.youtube.com/';

  @override
  void dispose() {
    _videoController?.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Handle the selected image
      print('Image path: ${pickedFile.path}');
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      _videoController = VideoPlayerController.file(File(pickedFile.path))
        ..initialize().then((_) {
          setState(() {});
        });
    }
  }

  void _playAudio() {
    _audioPlayer.play('audio_url.mp3' as Source); // Replace 'audio_url.mp3' with the actual audio file URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Pick Image'),
          ),
          ElevatedButton(
            onPressed: _pickVideo,
            child: Text('Pick Video'),
          ),
          _videoController != null
              ? AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          )
              : Container(),
          ElevatedButton(
            onPressed: _playAudio,
            child: Text('Play Audio'),
          ),
          // WebView(
          //   initialUrl: _webViewUrl,
          //   javascriptMode: JavascriptMode.unrestricted,
          // ),
        ],
      ),
    );
  }
}
