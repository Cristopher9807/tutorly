import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


// user_session.dart
class UserSession {
  static String? selectedRole;
  static String? phoneNumber;
  static String? fullName;
  static String? email;
  static String? password;
  static String? university;
  static String? specialty;
  static String? universityId;
  static String? uid;
  static String? role;

  static void fromFirebase(User user) {
    uid = user.uid;
    email = user.email;
    // Aquí puedes luego buscar más datos en Firestore si los necesitas
  }
}

