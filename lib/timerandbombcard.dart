import 'package:flutter/material.dart';

class TimerAndBombCard extends StatelessWidget {
  final String text;

  TimerAndBombCard(this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: Colors.amberAccent[700],
        elevation: 5,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSheetItem extends StatelessWidget {
  final text;
  final symbol;

  BottomSheetItem(this.text, this.symbol);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        Card(
          elevation: 2,
          color: Colors.amber,
          child: Container(
            height: 30,
            width: 27,
            child: FittedBox(
              child: Text(symbol),
            ),
          ),
        ),
      ],
    );
  }
}
