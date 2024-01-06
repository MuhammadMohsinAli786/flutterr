import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_sound/flutter_sound.dart';

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
  File? _pickedImage;
  VideoPlayerController? _videoController;
  TextEditingController _textController = TextEditingController();
  FlutterSoundPlayer? _audioPlayer;
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  String _currentRecording = '';
  Color _micIconColor = Colors.black; // Initial color

  _MyHomePageState() {
    _audioPlayer = FlutterSoundPlayer();
    _audioRecorder = FlutterSoundRecorder();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
        _videoController = null;
      });
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile = await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _videoController = VideoPlayerController.file(File(pickedFile.path))
          ..initialize().then((_) {
            _pickedImage = null;
            setState(() {});
          });
      });
    }
  }

  Future<void> _startRecording() async {
    try {
      await _audioRecorder!.openAudioSession();
      await _audioRecorder!.startRecorder(
        toFile: 'path/to/your/audio/file.aac',
        codec: Codec.aacMP4,
      );

      setState(() {
        _isRecording = true;
        _micIconColor = Colors.blue; // Change color to blue when recording starts
      });
    } catch (e) {
      print("Error starting recording: $e");
    }
  }

  Future<void> _stopRecording() async {
    try {
      String? path = await _audioRecorder!.stopRecorder();
      if (path != null) {
        setState(() {
          _isRecording = false;
          _currentRecording = path!;
          _micIconColor = Colors.black; // Reset color when recording stops
        });
      }
    } catch (e) {
      print("Error stopping recording: $e");
    }
  }

  @override
  void dispose() {
    _audioPlayer?.closeAudioSession();
    _audioRecorder?.closeAudioSession();
    _videoController?.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double containerSize = MediaQuery.of(context).size.width * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: containerSize,
                height: containerSize,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: _pickedImage != null
                    ? Image.file(_pickedImage!, fit: BoxFit.cover)
                    : IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: _pickImage,
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: containerSize,
                height: containerSize,
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: _videoController != null
                    ? AspectRatio(
                  aspectRatio: _videoController!.value.aspectRatio,
                  child: VideoPlayer(_videoController!),
                )
                    : IconButton(
                  icon: Icon(Icons.videocam),
                  onPressed: _pickVideo,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Text',
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    _isRecording
                        ? IconButton(
                      icon: Icon(Icons.stop),
                      onPressed: _stopRecording,
                      color: _micIconColor,
                    )
                        : IconButton(
                      icon: Icon(Icons.mic),
                      onPressed: _startRecording,
                      color: _micIconColor,
                    ),
                   // Adjust the spacing as needed

                  ],
                ),
              ),
              SizedBox(height: 20),
              if (_currentRecording.isNotEmpty)
                Text('Recorded Voice: $_currentRecording'),
            ],
          ),
        ),
      ),
    );
  }
}
