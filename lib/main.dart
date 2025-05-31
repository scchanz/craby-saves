import 'package:flutter/material.dart';
import 'screens/menu_page.dart';

void main() {
  runApp(const CrabGameApp());
}

class CrabGameApp extends StatelessWidget {
  const CrabGameApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Craby Saves',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
      ),
      home: const MenuPage(),
    );
  }
}
