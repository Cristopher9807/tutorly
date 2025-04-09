import 'package:flutter/material.dart';
// IMPORTA TUS PANTALLAS REALES, si corresponde:
 import 'role_separator.dart';

class Onboarding3 extends StatefulWidget {
  const Onboarding3({Key? key}) : super(key: key);

  @override
  Onboarding3State createState() => Onboarding3State();
}

class Onboarding3State extends State<Onboarding3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // SingleChildScrollView permite desplazar el contenido en pantallas pequeñas
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),

              // Imagen principal
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 41),
                child: Image.asset(
                  "assets/lesson.png",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 40),

              // Título
              const Text(
                "Impulsa tu aprendizaje",
                style: TextStyle(
                  color: Color(0xFF0760FB),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              // Descripción
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 47),
                child: Text(
                  "Aprender nunca ha sido tan fácil. Conéctate con expertos, mejora tus habilidades y alcanza tus objetivos académicos.",
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),

              // Indicador (dots)
                            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Círculo vacío
                  Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFF0760FB), // Azul
                        width: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Espacio entre elementos

                  // Círculo vacío
                  Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFF0760FB), // Azul
                        width: 2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8), // Espacio entre elementos
                  // Rectángulo redondeado (activo)
                  Container(
                    width: 21,
                    height: 9,
                    decoration: BoxDecoration(
                      color: Color(0xFF0760FB), // Azul
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  

                ],
              ),

              const SizedBox(height: 30),

              // Botones "Saltar" y "Continuar"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botón "Saltar"
                    InkWell(
                      onTap: () {
                        // Manda a la misma pantalla o función que necesites
                         Navigator.push(context,
                           MaterialPageRoute(builder: (_) => RoleSeparator()),
                         );
                        print('Saltar - misma función que en Onboarding1/Onboarding2');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF0760FB),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFFCDE6FE),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x12344054),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        width: 157,
                        child: const Center(
                          child: Text(
                            "Saltar",
                            style: TextStyle(
                              color: Color(0xFF0760FB),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Botón "Continuar" (misma función que "Saltar")
                    InkWell(
                      onTap: () {
                        // Manda a la misma pantalla o función que "Saltar"
                         Navigator.push(context,
                           MaterialPageRoute(builder: (_) => RoleSeparator()),
                         );
                        print('Continuar - misma función que Saltar');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color(0xFF0760FB),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x12344054),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        width: 157,
                        child: const Center(
                          child: Text(
                            "Continuar",
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
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
              const SizedBox(height: 30),

              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
