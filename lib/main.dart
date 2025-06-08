import 'package:flutter/material.dart';
import 'package:new_era/Screens/game_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Craby Egg Catcher',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const GameMenuPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
