import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(DiceGame());
}

class DiceGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DiceGamePage(),
    );
  }
}

class DiceGamePage extends StatefulWidget {
  @override
  _DiceGamePageState createState() => _DiceGamePageState();
}

class _DiceGamePageState extends State<DiceGamePage> {
  List<int> playerScores = [0, 0, 0, 0];
  int currentPlayer = 0;
  int totalTurns = 0;
  int diceNumber = 1;
  int winner = 0;
  int selectedTurns = 15;
  int extraRolls = 0;
  // AudioCache audioCache = AudioCache();
  // AudioPlayer audioPlayer = AudioPlayer();

  @override


  void resetGame() {
    setState(() {
      playerScores = [0, 0, 0, 0];
      currentPlayer = 0;
      totalTurns = 0;
      diceNumber = 1;
      winner = 0;
      extraRolls = 0;
    });
  }

  void determineWinner() {
    //audioPlayer = AudioPlayer();
    //audioPlayer.setAsset('audio/win.mp3');
    //audioPlayer.play('audio/win.mp3');

    _showWinnerDialog(winner);
  }

  setTurns() async {
    _showSetTurnsDialog();
  }

  Future<int?> _showSetTurnsDialog() async {
    int? newTurns;
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Set Turns"),
          content: TextField(
           keyboardType: TextInputType.number,
           controller: TextEditingController(text: selectedTurns.toString()),
           onChanged: (value) {
            newTurns = int.tryParse(value);
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Set"),
              onPressed: () {
                if (newTurns != null) {
                  setState(() {
                    selectedTurns = newTurns!;
                  });
                }
              //  audioPlayer.dispose();
                resetGame();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    return newTurns;
  }

  Future<void> playDiceRollSound() async {
   // audioPlayer = AudioPlayer();
   // audioPlayer.setAsset('audio/rolldice.mp3');
   // audioPlayer.play('audio/rolldice.mp3');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Text(
          'Dice Game',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[700],
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double diceSize = min(constraints.maxWidth, constraints.maxHeight) * 0.2;
          final double buttonSize = min(constraints.maxWidth, constraints.maxHeight) * 0.15;

          return Stack(
            children: [
              for (int player = 0; player < 4; player++)
                Positioned(
                  top: player < 2 ? 10 : null,
                  bottom: player >= 2 ? 10 : null,
                  left: player % 2 == 0 ? 10 : null,
                  right: player % 2 != 0 ? 10 : null,
                  child: buildPlayerWidget(player + 1, playerScores[player]),
                ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Player ${currentPlayer + 1}\'s Turn',
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                          fontFamily: 'Orbitron',
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: totalTurns < selectedTurns
                            ? () {
                          setState(() {
                            diceNumber = Random().nextInt(6) + 1;
                            playerScores[currentPlayer] += diceNumber;
                            totalTurns++;

                            if (diceNumber == 6) {
                              extraRolls++;
                            }

                            if (totalTurns >= selectedTurns || extraRolls == 2) {
                              determineWinner();
                            } else if (extraRolls == 1) {
                              extraRolls = 0;
                            } else {
                              currentPlayer = (currentPlayer + 1) % 4;
                            }

                            playDiceRollSound();
                          });
                        }
                            : null,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 50),
                          curve: Curves.easeInOut,
                          width: diceSize,
                          height: diceSize,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withOpacity(0.5),
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Image.asset(
                              'images/dice$diceNumber.png',
                              width: diceSize * 0.8,
                              height: diceSize * 0.8,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Text(
                        'Total Turns: $totalTurns / $selectedTurns',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontFamily: 'Orbitron',
                          letterSpacing: 2.0,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      if (winner != null)
                        // Text(
                        //   'Player ${winner + 1} wins!',
                        //   // style: TextStyle(
                        //   //   fontSize: 30.0,
                        //   //   color: Colors.yellow,
                        //   //   fontFamily: 'Orbitron',
                        //   //   letterSpacing: 2.0,
                        //   // ),
                        // ),
                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Set Turns: ',style: TextStyle(color: Colors.white,fontSize: 20),),

                          ElevatedButton(
                            onPressed: _showSetTurnsDialog,
                            child: Text('Set'),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: _showResetGameConfirmationDialog,
                        child: Text(
                          'Reset Game',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildPlayerWidget(int playerNumber, int score) {
    return Column(
      children: [
        Text(
          'Player $playerNumber',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Orbitron',
            letterSpacing: 2.0,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          '$score',
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Orbitron',
            letterSpacing: 2.0,
          ),
        ),
      ],
    );
  }

  _showResetGameConfirmationDialog() async {
    setState(() {});

    bool resetConfirmed = false;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Reset Game"),
          content: Text("Are you sure you want to reset the game?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Reset"),
              onPressed: () {
                setState(() {
                  resetConfirmed = true;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    if (resetConfirmed) {
      resetGame();
    }
  }

  _showWinnerDialog(int winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Congratulations"),
              content: Text("Player ${winner + 1} wins!"),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
