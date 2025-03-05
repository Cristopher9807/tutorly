import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'EnterPhoneNumber.dart'; // Si es necesario para los botones "Como tutor" y "Como estudiante"

class RoleSeparator extends StatefulWidget {
  const RoleSeparator({super.key});

  @override
  RoleSeparatorState createState() => RoleSeparatorState();
}

class RoleSeparatorState extends State<RoleSeparator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // SingleChildScrollView permite que el contenido se desplace en pantallas pequeñas
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Se elimina la barra superior (hora, batería, señal)

                const SizedBox(height: 40),

                // --- TÍTULO DE BIENVENIDA ---
                Text(
                  "¡Bienvenidos a Tutorly!\n¿Te gustaría unirte a nosotros?",
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Seleccione una opción de las siguientes",
                  style: const TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 40),

                // --- BOTÓN "Como tutor" ---
                InkWell(
                  onTap: () {
                    // Navegar a EnterPhoneNumber
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EnterPhoneNumber()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: const Color(0xFFCBD5E1),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x12344054),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 16),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        const Text(
                          "👨‍🏫",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(width: 9),
                        const Text(
                          "Como tutor",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // --- BOTÓN "Como estudiante" ---
                InkWell(
                  onTap: () {
                    // Navegar a EnterPhoneNumber
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EnterPhoneNumber()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF0760FB),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x26000000),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    child: Row(
                      children: [
                        const Text(
                          "👨‍🎓",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(width: 11),
                        const Text(
                          "Como estudiante",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // --- LINK "Iniciar sesión" ---
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
                              // Navegar a la pantalla de iniciar sesión
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (_) => SomeLoginScreen()),
                              // );
                            },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // --- BARRA DECORATIVA INFERIOR ---
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xFFE2E8F0),
                    ),
                    width: 132,
                    height: 6,
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
