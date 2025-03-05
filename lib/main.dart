import 'package:flutter/material.dart';
import 'Intro.dart'; // Asegúrate de que este archivo esté en la misma carpeta o ajusta la ruta.

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Intro(),
    );
  }
}
