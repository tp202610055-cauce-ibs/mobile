import 'package:flutter/material.dart';

void main() {
  runApp(const CauceApp());
}

class CauceApp extends StatelessWidget {
  const CauceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cauce Mobile',
      home: Scaffold(
        appBar: AppBar(title: const Text('Cauce Mobile')),
        body: const Center(child: Text('Cauce Mobile v0.1.0-foundations')),
      ),
    );
  }
}
