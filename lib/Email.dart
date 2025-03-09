import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'Education.dart';
import 'FullName.dart';

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  EmailState createState() => EmailState();
}

class EmailState extends State<Email> {
  String email = '';

  @override
  Widget build(BuildContext context) {
    // El botón Continuar se habilita solo si el campo no está vacío.
    bool isEmailFilled = email.isNotEmpty;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Botón "Atrás" en azul que lleva a CodeVerificaton.dart
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FullName()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.arrow_back, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        "Atrás",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Título
                const Text(
                  "¿Cuál es tu correo electrónico?",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Etiqueta "Correo electrónico"
                const Text(
                  "Correo electrónico",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Campo de texto para el email
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "ejemplo@dominio.com",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Botón "Continuar" que navega a Education.dart solo si el campo no está vacío
                InkWell(
                  onTap: isEmailFilled
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Education()),
                          );
                        }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isEmailFilled ? const Color(0xFF0760FB) : Colors.grey,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "Continuar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Enlace "¿Ya tienes una cuenta? Iniciar sesión" en azul (acción comentada)
                /*Center(
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
                              // Navegación a la pantalla de Login (acción comentada)
                              // Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
                            },
                        ),
                      ],
                    ),
                  ),
                ),*/
                const SizedBox(height: 30),

                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
