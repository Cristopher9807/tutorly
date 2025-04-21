import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 👈 Agregado
import 'package:tutorly/Onboarding1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'congrats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'user_session.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initializeDateFormatting('es_ES', null);
  Intl.defaultLocale = 'es_ES';

  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    UserSession.fromFirebase(user);
  }

  runApp(
    ScreenUtilInit(
      designSize: Size(375, 812),
      builder: (_, __) => MainApp(initialRoute: user != null ? '/home' : '/'),
    ),
  );
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


/*import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'verify_email_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('es_ES', null);
  runApp(const TutorlyApp());
}

class TutorlyApp extends StatelessWidget {
  const TutorlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tutorly',
      debugShowCheckedModeBanner: false,
      home: const VerifyEmailScreen(), // Solo mostramos esta pantalla
    );
  }
}*/


