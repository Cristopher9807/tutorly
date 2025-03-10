import 'package:flutter/material.dart';
import 'package:tutorly/Congrats.dart';
import 'Intro.dart'; // Asegúrate de que este archivo esté en la misma carpeta o ajusta la ruta.
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}


class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Intro(),
      routes: {
        'homePage': (context) => Congrats(),
      },

    );
  }
}
