import 'dart:io';
import 'dart:math';
import 'package:bottle_spin_game/player_screen.dart';
import 'package:flutter/material.dart';



class Task {
  final String name;
  final String description;

  Task(this.name, this.description);
}

class PlayerListScreen extends StatefulWidget {
  final List<Player> allplayers;
  final String? selectedImage;
  final String? selectedBottleImage;

  PlayerListScreen({
    required this.allplayers,
    this.selectedImage,
    this.selectedBottleImage,
  });

  @override
  _PlayerListScreenState createState() => _PlayerListScreenState();
}


class _PlayerListScreenState extends State<PlayerListScreen> with TickerProviderStateMixin {
  var lastPosition = 0.0;
  var random = Random();

  late AnimationController _animationController;
  bool _isRotating = false;
  Player? _highlightedPlayer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  void _highlightPlayer(Player player) {
    if (_highlightedPlayer == player) {
      _highlightedPlayer = null;
    } else {
      _highlightedPlayer = player;
    }
  }

  void _startRotationAnimation() {
    setState(() {
      _isRotating = true;
    });

    final randomAngle = random.nextDouble() * 4 * pi + 2 * pi;
    _animationController.forward(from: 0.0).whenComplete(() {
      _displayWinnerAndTaskDialog(randomAngle);
    });
  }

  void _displayWinnerAndTaskDialog(double randomAngle) {
    final winnerName = _highlightedPlayer?.name ?? "Unknown Winner";
    final task = Task("Sample Task", "This is a sample task.");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: Text('Winner and Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (task != null)
                  Text('Current Task: ${task.name} - ${task.description}'),
                Text('Winner: $winnerName'),
              ],
            ),
            actions: <Widget>[
        TextButton(
        child: Text('OK'),
        onPressed: () {
        Navigator.of(context).pop();
        },
        ) ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Bottle Spin'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(widget.selectedImage ?? 'assets/b6.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (widget.selectedImage != null)
                    CircleAvatar(
                      backgroundImage: FileImage(File(widget.selectedImage!)),
                      radius: 50,
                    ),
                  SizedBox(height: 20),
                  Container(
                    width: 400,
                    height: 400,
                    child: Stack(
                      alignment: Alignment.center,
                      children: widget.allplayers.map((player) {
                        final double angle = (2 * pi) / widget.allplayers.length;
                        final double playerAngle =
                            angle * widget.allplayers.indexOf(player);
                        final double x = 200.0 + (140.0 * cos(playerAngle));
                        final double y = 200.0 + (140.0 * sin(playerAngle));
                        return Positioned(
                          left: x - 50,
                          top: y - 50,
                          child: GestureDetector(
                            onTap: () {
                              _highlightPlayer(player);
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: player.imagePath != null
                                      ? FileImage(File(player.imagePath!))
                                      : null,
                                  radius: 30,
                                ),
                                Text(
                                  player.name,
                                  style: TextStyle(
                                    color: player == _highlightedPlayer
                                        ? Colors.red
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    if (!_isRotating) {
                      _startRotationAnimation();
                    }
                  },
                  child: RotationBottle(selectedBottleImage: widget.selectedBottleImage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RotationBottle extends StatefulWidget {
  final String? selectedBottleImage;

  RotationBottle({this.selectedBottleImage});

  @override
  _RotationBottleState createState() => _RotationBottleState();
}
class _RotationBottleState extends State<RotationBottle> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _randomAngle = 0.0;
  bool _isRotating = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
  }

  void _startRotationAnimation() {
    _generateRandomAngle();
    _animationController.forward(from: 0.0);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _displayWinnerAndTaskDialog();
        _stopRotationAnimation();
      }
    });
  }

  void _stopRotationAnimation() {
    _isRotating = false;
    _animationController.stop();
  }

  void _generateRandomAngle() {
    _randomAngle = Random().nextDouble() * 0.5 * pi + 4.5 * pi;
  }

  void _displayWinnerAndTaskDialog() {
    showDialog(
      context: context,
      builder: (context) {
        // Build your dialog content here, including the winner and task information
        return AlertDialog(
          title: Text('Winner and Task'),
          content: Column(
            children: <Widget>[
              Text('Winner: [Mohsin is Winner]'),
              Text('Task: [Sing A Song]'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!_isRotating) {
          _startRotationAnimation();
        }
      },
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return RotationTransition(
            turns: Tween(begin: 0.0, end: _randomAngle).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.linear,
              ),
            ),
            child: child,
          );
        },
        child: Image.asset(
          widget.selectedBottleImage ?? "assets/bt0.png",
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
