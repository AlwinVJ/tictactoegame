import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool playerturn = true; // The first player get X
  List<String> displaygame = ['', '', '', '', '', '', '', '', '', ''];
  static var playerstyle = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.white, letterSpacing: 3));
  static var scorestyle = GoogleFonts.pressStart2p(
      textStyle:
          const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 20));
  int oscore = 0;
  int xscore = 0;
  int draw = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: Column(
        children: [
          Expanded(
              child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 15),
                  child: Column(
                    children: [
                      Text(
                        'Player 1',
                        style: playerstyle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        xscore.toString(),
                        style: scorestyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, right: 15),
                  child: Column(
                    children: [
                      Text(
                        'Player 2',
                        style: playerstyle,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        oscore.toString(),
                        style: scorestyle,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400)),
                        child: Center(
                            child: Text(
                          displaygame[index],
                          style:
                              const TextStyle(color: Colors.white, fontSize: 40),
                        )),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }

  void _tapped(int indexed) {
    setState(() {
      if (playerturn && displaygame[indexed] == '') {
        displaygame[indexed] = 'X';
        draw++;
      } else if (!playerturn && displaygame[indexed] == '') {
        displaygame[indexed] = 'O';
        draw++;
      }
      playerturn = !playerturn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    if (displaygame[0] == displaygame[1] &&
        displaygame[1] == displaygame[2] &&
        displaygame[0] != '') {
      _showWinDialogue(displaygame[0]);
    }
    if (displaygame[3] == displaygame[4] &&
        displaygame[4] == displaygame[5] &&
        displaygame[5] != '') {
      _showWinDialogue(displaygame[3]);
    }
    if (displaygame[6] == displaygame[7] &&
        displaygame[7] == displaygame[8] &&
        displaygame[8] != '') {
      _showWinDialogue(displaygame[6]);
    }
    if (displaygame[0] == displaygame[3] &&
        displaygame[3] == displaygame[6] &&
        displaygame[6] != '') {
      _showWinDialogue(displaygame[3]);
    }
    if (displaygame[1] == displaygame[4] &&
        displaygame[4] == displaygame[7] &&
        displaygame[7] != '') {
      _showWinDialogue(displaygame[7]);
    }
    if (displaygame[2] == displaygame[5] &&
        displaygame[5] == displaygame[8] &&
        displaygame[8] != '') {
      _showWinDialogue(displaygame[8]);
    }
    if (displaygame[0] == displaygame[4] &&
        displaygame[4] == displaygame[8] &&
        displaygame[8] != '') {
      _showWinDialogue(displaygame[8]);
    }
    if (displaygame[2] == displaygame[4] &&
        displaygame[4] == displaygame[6] &&
        displaygame[6] != '') {
      _showWinDialogue(displaygame[6]);
    } else if (draw == 9) {
      _showDrawDialogue();
    }
  }

  void _showWinDialogue(String winner) {
    String gamewinner = '';
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(title: Text('Winner is $gamewinner'), actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: const Center(
                      child: Text(
                    'Play Again',
                    style: TextStyle(fontSize: 18),
                  )),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    _clearGame();
                    Navigator.of(context).pop();
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: const Center(
                      child: Text(
                    'Reset',
                    style: TextStyle(fontSize: 18),
                  )),
                )
              ],
            ),
          ]);
        });
    if (winner == 'X') {
      xscore += 1;
      gamewinner = 'Player 1';
    } else if (winner == 'O') {
      oscore += 1;
      gamewinner = 'Player 2';
    }
  }

  void _showDrawDialogue() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(title: const Text('Draw'), actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    _clearBoard();
                    Navigator.of(context).pop();
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: const Center(
                      child: Text(
                    'Play Again',
                    style: TextStyle(fontSize: 18),
                  )),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    _clearGame();
                    Navigator.of(context).pop();
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  child: const Center(
                      child: Text(
                    'Reset',
                    style: TextStyle(fontSize: 18),
                  )),
                ),
              ],
            ),
          ]);
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displaygame[i] = '';
      }
    });
    draw = 0;
  }

  void _clearGame() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displaygame[i] = '';
      }
      oscore = 0;
      xscore = 0;
      draw = 0;
    });
  }
}
