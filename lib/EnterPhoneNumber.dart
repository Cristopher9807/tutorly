/*import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/services.dart';
import 'Login.dart';
import 'CodeVerificaton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class EnterPhoneNumber extends StatefulWidget {
  const EnterPhoneNumber({super.key});

  @override
  EnterPhoneNumberState createState() => EnterPhoneNumberState();
}

class EnterPhoneNumberState extends State<EnterPhoneNumber> {
  final TextEditingController phoneController = TextEditingController();
  String countryCode = "+1"; // Código de país inicial
  String countryFlag = "🇺🇸"; // Bandera inicial (EE.UU.)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botón Atrás
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) =>  Login()),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back, color: Colors.blue),
                    const SizedBox(width: 8),
                    const Text(
                      "Atrás",
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Título
              const Text(
                "Introduce tu número",
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Descripción
              const Text(
                "Introduce tu número de teléfono para recibir el código de verificación.",
                style: TextStyle(
                  color: Color(0xFF475569),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),

              // Etiqueta
              const Text(
                "Número de teléfono móvil",
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Selección de país y campo de teléfono
              Row(
                children: [
                  // Botón para seleccionar país
                  InkWell(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          setState(() {
                            countryCode = "+${country.phoneCode}";
                            countryFlag = country.flagEmoji;
                          });
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Text(countryFlag, style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: 5),
                          Text(countryCode, style: const TextStyle(fontSize: 14)),
                          const Icon(Icons.arrow_drop_down, size: 16, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Campo de número de teléfono
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        maxLength: 10, // Limitar a 10 dígitos
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // Solo números
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "000-0000",
                          counterText: "", // Oculta el contador de caracteres
                          hintStyle: TextStyle(color: Color(0xFF64748B)),
                        ),
                        onChanged: (value) {
                          setState(() {}); // Actualizar UI
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Botón "Continuar"
              InkWell(
                onTap: phoneController.text.length == 10
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CodeVerificaton(countryCode: countryCode, phoneNumber: phoneController.text,)),
                        );
                      }
                    : null, // No hacer nada si está deshabilitado
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: phoneController.text.length == 10
                        ? const Color(0xFF0760FB)
                        : Colors.grey, // Azul cuando activo, gris cuando inactivo
                    boxShadow: [
                      if (phoneController.text.length == 10)
                        const BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Continuar",
                      style: TextStyle(
                        color: phoneController.text.length == 10 ? Colors.white : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Texto "¿Ya tienes una cuenta? Iniciar sesión"
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "¿Ya tienes una cuenta? ",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Iniciar sesión",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) =>  Login()),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Barra decorativa inferior
             
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Login.dart';
import 'CodeVerificaton.dart';

class EnterPhoneNumber extends StatefulWidget {
  const EnterPhoneNumber({super.key});

  @override
  EnterPhoneNumberState createState() => EnterPhoneNumberState();
}

class EnterPhoneNumberState extends State<EnterPhoneNumber> {
  final TextEditingController phoneController = TextEditingController();
  String countryCode = "+1"; // Código de país inicial
  String countryFlag = "🇺🇸"; // Bandera inicial (EE.UU.)

  // ✅ Función para guardar el número en Firestore
  void savePhoneNumber(String countryCode, String phoneNumber) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(phoneNumber).set({
        'phone': "$countryCode $phoneNumber",
        'createdAt': FieldValue.serverTimestamp(),
      });

      // ✅ Mostrar mensaje en pantalla
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("✅ Número guardado exitosamente"),
          backgroundColor: Colors.green,
        ),
      );

      print("✅ Número guardado en Firestore: $countryCode $phoneNumber");
    } catch (e) {
      print("❌ Error al guardar el número: $e");

      // ❌ Mostrar error en pantalla
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("❌ Error al guardar el número"),
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botón Atrás
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Login()),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_back, color: Colors.blue),
                    const SizedBox(width: 8),
                    const Text(
                      "Atrás",
                      style: TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Título
              const Text(
                "Introduce tu número",
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // Descripción
              const Text(
                "Introduce tu número de teléfono para recibir el código de verificación.",
                style: TextStyle(
                  color: Color(0xFF475569),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),

              // Etiqueta
              const Text(
                "Número de teléfono móvil",
                style: TextStyle(
                  color: Color(0xFF0F172A),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // Selección de país y campo de teléfono
              Row(
                children: [
                  // Botón para seleccionar país
                  InkWell(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode: true,
                        onSelect: (Country country) {
                          setState(() {
                            countryCode = "+${country.phoneCode}";
                            countryFlag = country.flagEmoji;
                          });
                        },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Text(countryFlag, style: const TextStyle(fontSize: 18)),
                          const SizedBox(width: 5),
                          Text(countryCode, style: const TextStyle(fontSize: 14)),
                          const Icon(Icons.arrow_drop_down, size: 16, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),

                  // Campo de número de teléfono
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        maxLength: 10, // Limitar a 10 dígitos
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly, // Solo números
                        ],
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "000-0000",
                          counterText: "", // Oculta el contador de caracteres
                          hintStyle: TextStyle(color: Color(0xFF64748B)),
                        ),
                        onChanged: (value) {
                          setState(() {}); // Actualizar UI
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Botón "Continuar"
              InkWell(
                onTap: phoneController.text.length == 10
                    ? () {
                        savePhoneNumber(countryCode, phoneController.text); // ✅ Guarda en Firestore
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CodeVerificaton(
                              countryCode: countryCode,
                              phoneNumber: phoneController.text,
                            ),
                          ),
                        );
                      }
                    : null, // No hacer nada si está deshabilitado
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: phoneController.text.length == 10
                        ? const Color(0xFF0760FB)
                        : Colors.grey, // Azul cuando activo, gris cuando inactivo
                    boxShadow: [
                      if (phoneController.text.length == 10)
                        const BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Continuar",
                      style: TextStyle(
                        color: phoneController.text.length == 10 ? Colors.white : Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
