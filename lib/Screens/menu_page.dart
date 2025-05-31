import 'package:flutter/material.dart';
import 'game_page.dart';
// import 'help_page.dart'; // opsional

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Kepiting Penjaga Laut',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const GamePage()),
                );
              },
              child: const Text('Mulai'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {  
                
                                
                
              },
              child: const Text('Petunjuk'),
            ),
          ],
        ),
      ),
    );
  }
}
