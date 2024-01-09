import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_sound/flutter_sound.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD0oBokSf_n1MWXzOIP2KS6ndq7Ue2EmMc",
      appId: "1:39537905776:android:2b6f2cea23aec1b2f7a4b5",
      messagingSenderId:"39537905776",
      projectId: "flutter-mobile-applicati-473c5",
    ),
  )
      :await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? _pickedImage;
  VideoPlayerController? _videoController;
  final TextEditingController _textController = TextEditingController();
  FlutterSoundPlayer? _audioPlayer;
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecording = false;
  String _currentRecording = '';
  Color _micIconColor = Colors.black;
  List<String> files = [];

  _MyHomePageState() {
    _audioPlayer = FlutterSoundPlayer();
    _audioRecorder = FlutterSoundRecorder();
  }

  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
        _videoController = null;
      });
    }
  }

  Future<void> _pickVideo() async {
    final pickedFile =
    await ImagePicker().pickVideo(source: ImageSource.gallery);

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
        _micIconColor = Colors.blue;
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
          _currentRecording = path;
          _micIconColor = Colors.black;
        });
      }
    } catch (e) {
      print("Error stopping recording: $e");
    }
  }

  void _createNewFile() {
    showDialog(
      context: context,
      builder: (context) {
        String content = '';

        return AlertDialog(
          title: const Text('New File'),
          content: TextField(
            onChanged: (value) {
              content = value;
            },
            maxLines: null,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _saveFile(content);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _saveFile(String content) {
    String fileName = 'File_${DateTime.now().millisecondsSinceEpoch}.txt';
    files.add(fileName);
    // Implement file saving logic and update the files list
    // For example, you can use a file name with a timestamp
    // Save content to the file - Implement this part based on your requirements
  }

  void _openAndEditFile(String fileName) {
    showDialog(
      context: context,
      builder: (context) {
        String content = ''; // Load the content of the file here

        return AlertDialog(
          title: Text(fileName),
          content: TextField(
            controller: TextEditingController(text: content),
            onChanged: (value) {
              content = value;
            },
            maxLines: null,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _saveFile(content);
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
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
    double fontSize = MediaQuery.of(context).size.width * 0.04;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
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
                  icon: const Icon(Icons.camera_alt),
                  onPressed: _pickImage,
                ),
              ),
              const SizedBox(height: 20),
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
                  icon: const Icon(Icons.videocam),
                  onPressed: _pickVideo,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _isRecording
                        ? IconButton(
                      icon: const Icon(Icons.stop),
                      onPressed: _stopRecording,
                      color: _micIconColor,
                    )
                        : IconButton(
                      icon: const Icon(Icons.mic),
                      onPressed: _startRecording,
                      color: _micIconColor,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Card(
                        elevation: 3.0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _textController,
                            style: TextStyle(fontSize: fontSize),
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter Text',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _createNewFile,
                child: const Icon(Icons.add),
              ),
              // List of Files
              Column(
                children: files.map((file) {
                  return ListTile(
                    title: Text(file),
                    onTap: () {
                      _openAndEditFile(file);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              if (_currentRecording.isNotEmpty)
                Text('Recorded Voice: $_currentRecording'),
            ],
          ),
        ),
      ),
    );
  }
}
