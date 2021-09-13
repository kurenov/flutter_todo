import 'package:flutter/material.dart';
import 'package:flutter_todo/pages/home.dart';
import 'package:flutter_todo/pages/main_screen.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.deepOrangeAccent
  ),
  // home: MainScreen(),
  initialRoute: '/',
  routes: {
    '/': (context) => MainScreen(),
    '/list': (context) => Home(),
  },
));
