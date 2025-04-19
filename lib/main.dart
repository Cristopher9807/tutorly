/*import 'package:flutter/material.dart';
import 'package:tutorly/Onboarding1.dart';

//import 'Intro.dart'; // Asegúrate de que este archivo esté en la misma carpeta o ajusta la ruta.
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
//import 'login.dart';
import 'congrats.dart';
  // Asegúrate de que este archivo esté en la misma carpeta o ajusta la ruta.
//import 'Congrats.dart'; // Asegúrate de que este archivo esté en la misma carpeta o ajusta la ruta.
import 'package:firebase_auth/firebase_auth.dart';
import 'user_session.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Verifica si ya hay un usuario logeado
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    UserSession.fromFirebase(user); // opcional pero útil
  }

  runApp(MainApp(initialRoute: user != null ? '/home' : '/login'));
}

class MainApp extends StatelessWidget {
  final String initialRoute;
  const MainApp({super.key, required this.initialRoute});
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
*/

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'ScheduleScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null);
  runApp(MyApp());
}


class TutorlyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutorly',
      debugShowCheckedModeBanner: false,
      home: ScheduleScreen(),  // Sólo mostramos esta pantalla
    );
  }
}


