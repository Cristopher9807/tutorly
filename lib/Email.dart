import 'package:flutter/material.dart';
import 'education.dart';
import 'full_name.dart';
import 'user_session.dart';

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  EmailState createState() => EmailState();
}

class EmailState extends State<Email> {
  String email = '';
  String password = '';
  String confirmPassword = '';
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    bool isFormValid = email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty && password == confirmPassword;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const Text(
                  "¿Cuál es tu correo electrónico?",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Correo electrónico",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                _buildInputField(
                  hintText: "ejemplo@dominio.com",
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Contraseña",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                _buildInputField(
                  hintText: "********",
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                      errorText = '';
                    });
                  },
                ),
                const SizedBox(height: 20),
                const Text(
                  "Confirmar contraseña",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                _buildInputField(
                  hintText: "********",
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      confirmPassword = value;
                      errorText = '';
                    });
                  },
                ),
                const SizedBox(height: 10),
                if (password != confirmPassword && confirmPassword.isNotEmpty)
                  const Text(
                    "Las contraseñas no coinciden",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: isFormValid
                      ? () {
                          // Guardar datos en la sesión
                          UserSession.email = email;
                          UserSession.password = password;

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Education()),
                          );
                        }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isFormValid ? const Color(0xFF0760FB) : Colors.grey,
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({required String hintText, bool obscureText = false, required Function(String) onChanged}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: TextField(
        obscureText: obscureText,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
