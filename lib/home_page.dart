import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mines/getAround.dart';
import './timerandbombcard.dart';
import './buttons.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  static List<String> text = [];
  static List<Color> color = [];
  static List<int> hasbom = [];
  static List<int> numOfbom = [];
  static List<bool> isSet = [];
  static bool isLooseOrWin = false;
  static int totalNumOfBomb = 10;
  static bool isStarted = false;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _timer = 0;
  @override
  void initState() {
    super.initState();
    buildButtons();
  }

  showBottomShet() {
    showModalBottomSheet(
      backgroundColor: Colors.amberAccent.shade100,
      context: context,
      builder: (_) => Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            BottomSheetItem('On long tap, set bomb →', '🚩'),
            SizedBox(
              height: 8,
            ),
            BottomSheetItem('On tap, open →', '1'),
            Divider(
              height: 20,
              color: Color(0xffaaaaaa),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: RaisedButton(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.amber,
                child: Text(
                  'Solve',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  Timer(Duration(milliseconds: 300), () {
                    Buttons btn = Buttons(
                        Random().nextInt(81), () => a(), () => increaseTimer());
                    btn.solve(Random().nextInt(81));
                  });
                },
              ),
            ),
            Divider(
              height: 20,
              color: Color(0xffaaaaaa),
            ),
            Text('Developed by:', textAlign: TextAlign.center),
            SizedBox(height: 10),
            Text('- Eng. Ahmed Abd Elmonem Ahmed.'),
            Text('- Eng. Adel Ayman Mostafa.'),
            Text('- Eng. Adel Yasser Taha.'),
            Text('- Eng. Abd Elrahman Anwar Abdo.'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: floatingActionButton(),
      backgroundColor: Colors.amberAccent,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Minesweeper"),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                CupertinoIcons.info,
              ),
              onPressed: () {
                showBottomShet();
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                TimerAndBombCard('💣 ${HomePage.totalNumOfBomb}'),
                TimerAndBombCard('$_timer'),
              ],
            ),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Column(
                    children: <Widget>[
                      row(0, 8),
                      row(9, 17),
                      row(18, 26),
                      row(27, 35),
                      row(36, 44),
                      row(45, 53),
                      row(54, 62),
                      row(63, 71),
                      row(72, 80),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton floatingActionButton() {
    if (HomePage.isLooseOrWin)
      return FloatingActionButton(
        onPressed: () {
          HomePage.text.clear();
          HomePage.color.clear();
          HomePage.hasbom.clear();
          HomePage.numOfbom.clear();
          HomePage.isSet.clear();
          HomePage.isLooseOrWin = false;
          HomePage.isStarted = false;
          HomePage.totalNumOfBomb = 10;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => HomePage()),
          );
        },
        child: Icon(
          Icons.replay,
          size: 30,
        ),
      );
    else
      return null;
  }

  void buildButtons() {
    HomePage.text.addAll(Iterable.generate(81, (_) => ''));
    HomePage.color.addAll(Iterable.generate(81, (_) => Colors.amber.shade200));
    HomePage.isSet.addAll(Iterable.generate(81, (_) => false));

    int i = 0;
    while (i < 10) {
      int rand = Random().nextInt(81);
      if (!HomePage.hasbom.contains(rand)) {
        HomePage.hasbom.add(rand);
        i++;
      }
    }
    HomePage.numOfbom.addAll(Iterable.generate(81, (i) => numbom(i)));
  }

  int numbom(int i) {
    int number = 0;
    getAround(i).forEach((n) {
      if (HomePage.hasbom.contains(n)) {
        number++;
      }
    });
    return number;
  }

  void increaseTimer() {
    Timer.periodic(Duration(seconds: 1), (t) {
      setState(() {
        _timer++;
      });
      if (!HomePage.isStarted)
        setState(() {
          t.cancel();
        });
    });
  }

  Expanded row(int start, int end) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (; start <= end; start++)
            Buttons(start, () => a(), () => increaseTimer()),
        ],
      ),
    );
  }

  a() {
    setState(() {});
  }
}
