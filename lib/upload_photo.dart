import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'congrats.dart';
import 'education.dart';
import 'user_session.dart';

class UploadPhoto extends StatefulWidget {
  const UploadPhoto({super.key});

  @override
  UploadPhotoState createState() => UploadPhotoState();
}

class UploadPhotoState extends State<UploadPhoto> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _registerUser() async {
    try {
      // Crear usuario en Firebase Authentication
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: UserSession.email!,
        password: UserSession.password!,
      );

      // Determinar colección según el rol
      final String selectedRole = UserSession.selectedRole?.toLowerCase() ?? '';
      String collectionName;

      if (selectedRole == 'tutor') {
        collectionName = 'tutors';
      } else if (selectedRole == 'estudiante') {
        collectionName = 'users';
      } else {
        throw Exception('Rol no válido: $selectedRole');
      }

      debugPrint("📂 Guardando en la colección: $collectionName");

      // Guardar datos en la colección correspondiente de Firestore
      await FirebaseFirestore.instance
          .collection(collectionName)
          .doc(UserSession.email)
          .set({
        'role': UserSession.selectedRole,
        'phone': UserSession.phoneNumber,
        'fullName': UserSession.fullName,
        'email': UserSession.email,
        'university': UserSession.university,
        'specialty': UserSession.specialty,
        'universityId': UserSession.universityId,
      });

      debugPrint("✅ Usuario registrado correctamente en Auth y Firestore");

      // Navegar a pantalla de felicitaciones
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const Congrats()),
        );
      }
    } catch (e) {
      debugPrint("❌ Error al registrar usuario: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error al registrar el usuario"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Botón Atrás
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Education()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.arrow_back, color: Colors.blue),
                      SizedBox(width: 8),
                      Text("Atrás", style: TextStyle(color: Colors.blue)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Subir foto",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Sube tu foto de perfil para finalizar el registro",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: _pickImage,
                child: Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey[300],
                  ),
                  child: _image != null
                      ? ClipOval(child: Image.file(_image!, fit: BoxFit.cover))
                      : const Center(
                          child: Text(
                            "Haz clic en el círculo\npara cargar tu foto",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 30),

              // Botón Saltar (con registro)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _registerUser,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.blue),
                  ),
                  child: const Text("Saltar"),
                ),
              ),

              // Botón Continuar (desactivado)
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text("Continuar (desactivado)"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
