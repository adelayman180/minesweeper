import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:mines/home_page.dart';
import './getAround.dart';

class Buttons extends StatelessWidget {
  final int index;
  final Function function;
  final Function increaseTimer;
  Buttons(this.index, this.function, this.increaseTimer);

  int numOfBomb = 0;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        onLongPress: () => onLongPress(index),
        child: Card(
          margin: EdgeInsets.all(1),
          color: HomePage.color[index],
          child: FittedBox(
              child: Text(HomePage.isSet[index] ? '🚩' : HomePage.text[index])),
        ),
      ),
    );
  }

  void onLongPress(int index) {
    if (!HomePage.isLooseOrWin) {
      if (!HomePage.isStarted) {
        HomePage.isStarted = true;
        increaseTimer();
      }
      if (HomePage.isSet[index]) {
        HomePage.isSet[index] = !HomePage.isSet[index];
        HomePage.totalNumOfBomb++;
        function();
      } else if (HomePage.totalNumOfBomb > 0 &&
          HomePage.color[index] == Colors.amber.shade200) {
        HomePage.isSet[index] = !HomePage.isSet[index];
        HomePage.totalNumOfBomb--;
        function();
      }
    }
  }

  void onTap(int index) {
    if (!HomePage.isLooseOrWin) {
      if (HomePage.hasbom.contains(index)) {
        HomePage.hasbom.forEach((b) {
          changeButton(b);
        });
        HomePage.isLooseOrWin = true;
        HomePage.isStarted = false;
        function();
      } else {
        if (!HomePage.isStarted) {
          HomePage.isStarted = true;
          increaseTimer();
        }
        if (!HomePage.isSet[index]) {
          if (HomePage.color[index] == Colors.amber.shade200) {
            onClick(index);
            function();
          }
        }
      }
      int n = 0;
      for (int i = 0; i < 81; i++) {
        if (!HomePage.hasbom.contains(i) &&
            HomePage.color[i] != Colors.amber[400]) {
          n++;
        }
      }
      if (n == 0) {
        HomePage.isLooseOrWin = true;
        HomePage.isStarted = false;
        function();
      }
    }
  }

  void onClick(int i) {
    changeButton(i);
    if (HomePage.numOfbom[i] == 0 && !HomePage.hasbom.contains(i))
      getAround(i).forEach((n) {
        if (n != null &&
            HomePage.numOfbom[n] == 0 &&
            !HomePage.hasbom.contains(n)) {
          onClick1(n);
        }
      });
  }

  void onClick1(int i) {
    changeButton(i);
    if (HomePage.numOfbom[i] == 0 && !HomePage.hasbom.contains(i))
      getAround(i).forEach((n) {
        if (n != null &&
            HomePage.numOfbom[n] == 0 &&
            !HomePage.hasbom.contains(n)) {
          onClick2(n);
        }
      });
  }

  void onClick2(int i) {
    changeButton(i);
    if (HomePage.numOfbom[i] == 0 && !HomePage.hasbom.contains(i))
      getAround(i).forEach((n) {
        if (n != null &&
            HomePage.numOfbom[n] == 0 &&
            !HomePage.hasbom.contains(n)) {
          onClick3(n);
        }
      });
  }

  void onClick3(int i) {
    changeButton(i);
    if (HomePage.numOfbom[i] == 0 && !HomePage.hasbom.contains(i))
      getAround(i).forEach((n) {
        if (n != null &&
            HomePage.numOfbom[n] == 0 &&
            !HomePage.hasbom.contains(n)) {
          changeButton(n);
          changeAll(n);
        }
      });
  }

  void changeAll(int i) {
    if (i != null) {
      getAround(i).forEach((n) {
        changeButton(n);
      });
    }
  }

  void changeButton(int i) {
    if (i != null && !HomePage.isSet[i]) {
      numOfBomb = HomePage.numOfbom[i];
      HomePage.color[i] =
          HomePage.hasbom.contains(i) ? Colors.red : Colors.amber[400];
      HomePage.text[i] = HomePage.hasbom.contains(i)
          ? '💣'
          : (numOfBomb == 0 ? '' : numOfBomb.toString());
    }
  }

  void chColor(int i) {
    Color color = HomePage.color[i];
    HomePage.color[i] = Colors.amber.shade900;
    function();
    Timer(Duration(milliseconds: 200), () {
      HomePage.color[i] = color;
      function();
    });
  }

  void solve(int i) {
    Queue<int> queue = Queue();
    chColor(i);
    Timer(Duration(milliseconds: 300), () {
      onTap(i);
      getAround(i).forEach((b) {
        if (b != null &&
            HomePage.color[b] == Colors.amber.shade200 &&
            HomePage.text[b] == '' &&
            !HomePage.isSet[b]) queue.add(b);
      });
      if (!HomePage.isLooseOrWin)
        Timer.periodic(Duration(milliseconds: 400), (t) {
          if (HomePage.isLooseOrWin) {
            t.cancel();
            if (HomePage.totalNumOfBomb != 0) {
              HomePage.hasbom.forEach((b) {
                HomePage.isSet[b] = true;
              });
              HomePage.totalNumOfBomb = 0;
              function();
            }
          }
          if (queue.isEmpty)
            for (int i = 80; i >= 0; i--) {
              if (HomePage.color[i] == Colors.amber.shade200 &&
                  HomePage.text[i] == '' &&
                  !HomePage.isSet[i]) {
                queue.add(i);
              }
            }
          queue
              .removeWhere((q) => (HomePage.color[q] != Colors.amber.shade200));
          int btn = queue.first;
          queue.removeFirst();
          chColor(btn);
          Timer(Duration(milliseconds: 300), () {
            if (HomePage.hasbom.contains(btn) && !HomePage.isSet[btn]) {
              onLongPress(btn);
              getAround(btn).forEach((b) {
                if (b != null &&
                    HomePage.color[b] == Colors.amber.shade200 &&
                    HomePage.text[b] == '' &&
                    !queue.contains(b) &&
                    !HomePage.isSet[b]) queue.add(b);
              });
            } else if (!HomePage.hasbom.contains(btn)) {
              onTap(btn);
              getAround(btn).forEach((b) {
                if (b != null &&
                    HomePage.color[b] == Colors.amber.shade200 &&
                    HomePage.text[b] == '' &&
                    !queue.contains(b) &&
                    !HomePage.isSet[b]) queue.add(b);
              });
            }
          });
        });
    });
  }
}
