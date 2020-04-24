import 'package:flutter/material.dart';
import './home_page.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  AnimationController controllerText;
  AnimationController controllerbomb;
  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 6));
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    controllerText =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    controllerbomb =
        AnimationController(vsync: this, duration: Duration(seconds: 2));

    controller.reverse(from: 1);
    controllerbomb.forward(from: 0);
    controller.addStatusListener((_) {
      if (controller.isDismissed) {
        controllerText.forward(from: 0);
        controllerText.addListener(() {
          setState(() {});
        });
      }
    });
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    controllerText.dispose();
    controllerbomb.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: InkWell(
        highlightColor: Colors.amber,
        onTap: () {
          setState(() {
            controller.value = 0;
            controllerText.value = 1;
            controllerbomb.value = 1;
          });
        },
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(width: -controllerbomb.value * 333 + 333),
                    Text("💣",
                        style: TextStyle(fontSize: 55 * controllerbomb.value)),
                    SizedBox(width: animation.value * 333),
                    Text("Mines", style: TextStyle(fontSize: 30)),
                    SizedBox(width: animation.value * 333),
                    Text("weeper", style: TextStyle(fontSize: 30)),
                  ],
                ),
                SizedBox(height: 100 * controllerText.value),
                FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  },
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Text(
                    "Start",
                    style: TextStyle(
                        fontSize: 22 * controllerText.value,
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(controllerText.value)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
