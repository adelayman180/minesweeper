import 'package:flutter/material.dart';
import './welcome_page.dart';

main(List<String> args) {
  runApp(
    MaterialApp(
      home: WelcomePage(),
      theme: ThemeData(
          primaryColor: Colors.amber, accentColor: Colors.amber.shade700),
    ),
  );
}
