import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'user_session.dart';

class FirebaseService {
  static Future<void> saveUserDataToFirestore() async {
    final selectedRole = UserSession.selectedRole?.toLowerCase();
    debugPrint("🎯 Rol actual: $selectedRole");

    String collectionName;
    if (selectedRole == 'tutor') {
      collectionName = 'tutors';
    } else if (selectedRole == 'estudiante') {
      collectionName = 'users';
    } else {
      throw Exception('Rol no válido: $selectedRole');
    }

    debugPrint("📂 Guardando en la colección: $collectionName");

    final targetCollection = FirebaseFirestore.instance.collection(collectionName);

    await targetCollection.doc(UserSession.email).set({
      'role': UserSession.selectedRole,
      'phone': UserSession.phoneNumber,
      'fullName': UserSession.fullName,
      'email': UserSession.email,
      'password': UserSession.password,
      'university': UserSession.university,
      'specialty': UserSession.specialty,
      'universityId': UserSession.universityId,
    });

    debugPrint("✅ Datos guardados correctamente en $collectionName");
  }
}
