import 'package:flutter/material.dart';
import 'package:tutorly/Onboarding1.dart';
//import 'Intro.dart'; // Asegúrate de que este archivo esté en la misma carpeta o ajusta la ruta.
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
//import 'login.dart';
import 'congrats.dart';
  // Asegúrate de que este archivo esté en la misma carpeta o ajusta la ruta.
//import 'Congrats.dart'; // Asegúrate de que este archivo esté en la misma carpeta o ajusta la ruta.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      initialRoute: '/',
      routes: {
        '/': (context) => Onboarding1(),
        '/Congrats': (context) => Congrats(), 
      },
    );
  }
}
