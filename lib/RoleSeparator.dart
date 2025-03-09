import 'package:flutter/material.dart';
import 'Login.dart';

class RoleSeparator extends StatefulWidget {
  const RoleSeparator({super.key});

  @override
  RoleSeparatorState createState() => RoleSeparatorState();
}

class RoleSeparatorState extends State<RoleSeparator> {
  @override
  Widget build(BuildContext context) {
    // Obtener dimensiones de la pantalla
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double textSize = screenWidth * 0.05; // Escalar texto según ancho de pantalla
    double buttonWidth = screenWidth * 0.6; // Botones ocupan 60% del ancho
    double buttonHeight = screenHeight * 0.07; // Altura del botón relativa a la pantalla

    return Scaffold(
      body: SafeArea(
        child: Center( // Centra el contenido en la pantalla
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // --- TÍTULO DE BIENVENIDA ---
                Text(
                  "¡Bienvenidos a Tutorly!\nEmpieza tu enseñanza o únetenos",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF0F172A),
                    fontSize: textSize * 1.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  "Seleccione una opción de las siguientes",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: textSize * 0.8,
                  ),
                ),

                const SizedBox(height: 40),

                // --- BOTÓN "Como tutor" ---
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Login()),
                    );
                  },
                  child: Container(
                    width: buttonWidth, // Tamaño adaptable
                    height: buttonHeight, // Altura adaptable
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF0760FB),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("👨‍🏫", style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 10),
                        Text(
                          "Como tutor",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: textSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // --- BOTÓN "Como estudiante" ---
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Login()),
                    );
                  },
                  child: Container(
                    width: buttonWidth,
                    height: buttonHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF0760FB),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("👨‍🎓", style: TextStyle(fontSize: 24)),
                        const SizedBox(width: 10),
                        Text(
                          "Como estudiante",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: textSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
