import 'dart:developer';

import 'package:flutter/material.dart';

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  Color darkPink = Color(0xffBA2C3C);
  Color lightPink = Color(0xffF24678);
  List<String> texts = ['', '', '', '', '', '', '', '', ''];
  bool xTurn = true;
  String x = 'X';
  String o = 'O';
  int inputCount = 0;
  String winner = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('TicTacToe')),
      body: Column(
        children: [
          SizedBox(
            height: 400,
            child: GridView(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
              ),
              children: List<InkWell>.generate(9, (index) {
                return InkWell(
                  onTap: () {

                    setState(() {
                      if (texts[index].isEmpty && winner.isEmpty) {
                        if (xTurn) {
                          texts[index] = x;
                          xTurn = false;
                        } else {
                          texts[index] = o;
                          xTurn = true;
                        }
                        ++inputCount;
                        winner = getWinner();
                        log('This is winner $winner');
                        if (winner.isNotEmpty) {
                          Future.delayed(const Duration(seconds: 1), () => resetGame());
                        }
                        print(texts);
                      }
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    color: (index + 1) % 2 == 0 ? darkPink : lightPink,
                    child: Center(
                      child: Text(
                        texts[index],
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          if (winner.isNotEmpty)
            Text(
              '$winner Wins',
              style: TextStyle(fontSize: 30, color: darkPink, fontWeight: FontWeight.bold),
            ),
          FilledButton(
              onPressed: () {
                resetGame();
              },
              style: FilledButton.styleFrom(
                  backgroundColor: darkPink,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  padding: EdgeInsets.symmetric(horizontal: 22, vertical: 6)),
              child: Text('Play Again',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)))
        ],
      ),
    );
  }


  String getWinner() {
    if (isSame(texts[0], texts[1], texts[2])) {
      log('inside working condition');
      return texts[0];
    } else if (isSame(texts[3], texts[4], texts[5])) {
      return texts[3];
    } else if (isSame(texts[6], texts[7], texts[8])) {
      return texts[6];
    } else if (isSame(texts[0], texts[3], texts[6])) {
      return texts[0];
    } else if (isSame(texts[1], texts[4], texts[7])) {
      return texts[1];
    } else if (isSame(texts[2], texts[5], texts[8])) {
      return texts[2];
    } else if (isSame(texts[0], texts[4], texts[8])) {
      return texts[0];
    } else if (isSame(texts[2], texts[4], texts[6])) {
      return texts[2];
    }
    return '';
  }

  bool isSame(String first, String second, String third) {
    if(first.isNotEmpty && second.isNotEmpty && third.isNotEmpty) {
      return first == second && second == third;
    }
    return false;
  }

  void resetGame() {
    setState(() {
     texts= ['', '', '', '', '', '', '', '', ''];
      winner = '';
      print(winner.isEmpty);
    });
  }
}
