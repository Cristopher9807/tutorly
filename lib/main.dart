import 'package:flutter/material.dart';
import 'package:tutorly/Onboarding1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'congrats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_session.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart'; // 👈 Import necesario

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa Firebase
  await Firebase.initializeApp();

  // Inicializa los datos de localización
  await initializeDateFormatting('es_ES', null); // 👈 Esto es crítico
  print(DateFormat.yMMMMEEEEd('es_ES').format(DateTime.now()));

  // Establece locale por defecto
  Intl.defaultLocale = 'es_ES';

  // Verifica si hay un usuario autenticado
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    UserSession.fromFirebase(user);
  }

  runApp(MainApp(initialRoute: user != null ? '/home' : '/'));
  
}


class MainApp extends StatelessWidget {
  final String initialRoute;
  const MainApp({super.key, required this.initialRoute});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter App',
      initialRoute: initialRoute,
      routes: {
        '/': (context) => Onboarding1(),
        '/Congrats': (context) => Congrats(), 
      },
    );
  }
}
















/*import 'package:flutter/material.dart';
import 'package:tutorly/Onboarding1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'congrats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_session.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
}*/
/*

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

*/
