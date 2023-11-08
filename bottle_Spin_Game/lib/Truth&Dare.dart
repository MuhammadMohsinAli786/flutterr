import 'package:bottle_spin_game/Components/My_Button.dart';
import 'package:bottle_spin_game/PlayerListScreen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';
import 'package:bottle_spin_game/player_screen.dart';

class Task {
  final String name;
  final String description;

  Task(this.name, this.description);
}

class TruthDare extends StatefulWidget {
  TruthDare({Key? key}) : super(key: key);

  @override
  _TruthDareState createState() => _TruthDareState();
}

class _TruthDareState extends State<TruthDare> {
  List<Player> players = [];
  List<DropdownMenuItem<Player>> playerDropdownItems = [];
  String? selectedBackgroundImage;
  String? selectedBottleImage;
  int numberOfPlayersToAdd = 2;
  int selectedImageIndex = -1;

  List<String> backgroundImages = [
    'assets/m.jpg',
    'assets/b1.jpeg',
    'assets/b2.jpeg',
    'assets/b3.jpeg',
    'assets/b4.jpeg',
    'assets/b5.jpeg',
    'assets/b6.jpg',
  ];

  List<String> bottleImages = [
    'assets/bt0.png',
    'assets/bt1.jpeg',
    'assets/bt2.jpeg',
    'assets/bt3.jpeg',
    'assets/bt4.jpeg',
  ];

  List<Task> tasks = [];

  @override
  void initState() {
    super.initState();
    playerDropdownItems = players.map((player) {
      return DropdownMenuItem<Player>(
        value: player,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: player.imagePath != null
                  ? FileImage(File(player.imagePath!))
                  : null,
            ),
            SizedBox(width: 8),
            Text(player.name),
          ],
        ),
      );
    }).toList();
  }

  void _chooseImages() async {
    List<String> assetImages = [
      'assets/m.jpg',
      'assets/b1.jpeg',
      'assets/b2.jpeg',
      'assets/b3.jpeg',
      'assets/b4.jpeg',
      'assets/b5.jpeg',
      'assets/b6.jpg',
    ];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Choose an Image'),
          content: SingleChildScrollView(
            child: Column(
              children: List.generate(assetImages.length, (index) {
                String assetPath = assetImages[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedBackgroundImage = assetPath;
                      selectedImageIndex = index;
                    });
                    Navigator.pop(context);
                  },
                  child: Card(
                    color: index == selectedImageIndex ? Colors.green : null,
                    child: Image.asset(assetPath),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSelectBottleButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Select a Bottle Image'),
              content: SingleChildScrollView(
                child: Column(
                  children: List.generate(bottleImages.length, (index) {
                    String bottleImage = bottleImages[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBottleImage = bottleImage;
                        });
                        Navigator.pop(context);
                      },
                      child: Card(
                        color: selectedBottleImage == bottleImage
                            ? Colors.green
                            : null,
                        child: Image.asset(bottleImage, height: 40, width: 40),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width-10,
        height: MediaQuery.of(context).size.width*0.1,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            'Select Bottle',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }

  void _addPlayers(int numberOfPlayers) async {
    for (int i = 0; i < numberOfPlayers; i++) {
      TextEditingController playerNameController = TextEditingController();
      XFile? imageFile;
      bool playerAdded = false;

      await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Add Player'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: imageFile != null
                          ? FileImage(File(imageFile!.path))
                          : null,
                      child: IconButton(
                        icon: Icon(Icons.camera_alt),
                        onPressed: () async {
                          XFile? pickedFile = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );
                          if (pickedFile != null) {
                            print("Image selected: ${pickedFile.path}");
                            setState(() {
                              imageFile = pickedFile;
                            });
                          }
                        },
                      ),
                    ),
                    TextField(
                      controller: playerNameController,
                      decoration: InputDecoration(labelText: 'Player Name'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: MyButton(
                        title: 'Add Player',
                        colors: Colors.greenAccent,
                        onpress: () {
                          if (playerNameController.text.isNotEmpty) {
                            setState(() {
                              final player = Player(
                                playerNameController.text,
                                imageFile?.path,
                              );
                              players.add(player);
                              print("Player added: ${player.name}, ${player.imagePath}");
                              playerAdded = true;
                              playerDropdownItems.add(DropdownMenuItem<Player>(
                                value: player,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: player.imagePath != null
                                          ? FileImage(File(player.imagePath!))
                                          : null,
                                    ),
                                    SizedBox(width: 8),
                                    Text(player.name),
                                  ],
                                ),
                              ));
                            });
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );

      if (!playerAdded) {
        if (imageFile != null) {
          File(imageFile!.path).delete();
        }
      }
    }

    players.sort((a, b) => a.name.compareTo(b.name));
    setState(() {
      playerDropdownItems = players.map((player) {
        return DropdownMenuItem<Player>(
          value: player,
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: player.imagePath != null
                    ? FileImage(File(player.imagePath!))
                    : null,
              ),
              SizedBox(width: 8),
              Text(player.name),
            ],
          ),
        );
      }).toList();
    });
  }

  void addTask(Task task) {
    tasks.add(task);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text("Truth & Dare"),
        actions: <Widget>[

        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildSelectBottleButton(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildSelectBackgroundButton(),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: _buildNumberSelectionButton(),
            ),
            DropdownButton<Player>(
              items: playerDropdownItems,
              onChanged: (selectedPlayer) {
                print("Selected player: ${selectedPlayer?.name}");
              },
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: MyButton(
                title: 'Truth & Dare',
                colors: Colors.green,
                onpress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerListScreen(
                        allplayers: players,
                        selectedImage: selectedBackgroundImage,
                        selectedBottleImage: selectedBottleImage,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.green)
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Add Task'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              decoration: InputDecoration(labelText: 'Task Name'),
                            ),
                            SizedBox.square(),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(Colors.lightGreenAccent)
                              ),
                              onPressed: () {
                                // Handle adding the task
                                String taskName = "Example Task"; // Replace with the actual task name
                                String taskDescription = "Task description"; // Replace with the actual task description
                                addTask(Task(taskName, taskDescription));

                                Navigator.pop(context);
                              },
                              child: Text('Add Task'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text('Add Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectBackgroundButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Select a Background Image'),
              content: SingleChildScrollView(
                child: Column(
                  children: List.generate(backgroundImages.length, (index) {
                    String backgroundImage = backgroundImages[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedBackgroundImage = backgroundImage;
                        });
                        Navigator.pop(context);
                      },
                      child: Card(
                        color: selectedBackgroundImage == backgroundImage
                            ? Colors.green
                            : null,
                        child: Image.asset(backgroundImage, height: 40, width: 40),
                      ),
                    );
                  }),
                ),
              ),
            );
          },
        );
      },

      child: Container(
        width: MediaQuery.of(context).size.width-10,
        height: MediaQuery.of(context).size.width*0.1,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            'Select Background',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildNumberSelectionButton() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  title: Text('Select Number of Players to Add'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Slider(
                        value: numberOfPlayersToAdd.toDouble(),
                        min: 1,
                        max: 10,
                        onChanged: (value) {
                          setState(() {
                            numberOfPlayersToAdd = value.toInt();
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            numberOfPlayersToAdd.toString(),
                            style: TextStyle(fontSize: 24),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: MyButton(
                          title: 'Add Players',
                          colors: Colors.green,
                          onpress: () {
                            Navigator.pop(context);
                            _addPlayers(numberOfPlayersToAdd);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width-10,
        height: MediaQuery.of(context).size.width*0.1,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green,
          border: Border.all(color: Colors.black45),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            'Add Players: $numberOfPlayersToAdd',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
