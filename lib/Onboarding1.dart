import 'package:flutter/material.dart';
// IMPORTA TUS PANTALLAS REALES:
 import 'RoleSeparator.dart';
 import 'Onboarding2.dart';

class Onboarding1 extends StatefulWidget {
  const Onboarding1({Key? key}) : super(key: key);

  @override
  Onboarding1State createState() => Onboarding1State();
}

class Onboarding1State extends State<Onboarding1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // SingleChildScrollView permite desplazar el contenido si la pantalla es pequeña
        child: SingleChildScrollView(
          child: Center(
            // Center para centrar horizontalmente la columna
            child: Column(
              children: [
                const SizedBox(height: 60),
                // Imagen principal
                SizedBox(
                  width: 273,
                  height: 273,
                  child: Image.network(
                    "https://storage.googleapis.com/tagjs-prod.appspot.com/VuZ5hgGxQ3/lnug0ns9.png",
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 40),
                // Título
                const Text(
                  "Supera tus dificultades",
                  style: TextStyle(
                    color: Color(0xFF0760FB),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Descripción
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 38, vertical: 19),
                  child: Text(
                    "¿Hay temas que te resultan difíciles? No te frustres, aquí estamos para ayudarte a aprender de la mejor manera.",
                    style: TextStyle(
                      color: Color(0xFF475569),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                // Indicador de progreso/dots (imagen)
                SizedBox(
                  width: 44,
                  height: 8,
                  child: Image.network(
                    "https://storage.googleapis.com/tagjs-prod.appspot.com/VuZ5hgGxQ3/i8mfn1el.png",
                    fit: BoxFit.fill,
                  ),
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
                          // Navega a RoleSeparator
                           Navigator.push(
                             context,
                             MaterialPageRoute(builder: (_) => RoleSeparator()),
                           );
                          print('Ir a RoleSeparator');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFF0760FB),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFCDE6FE),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x12344054),
                                blurRadius: 2,
                                offset: Offset(0, 1),
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
                      // Botón "Continuar"
                      InkWell(
                        onTap: () {
                          // Navega a Onboarding2
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => Onboarding2()),
                           );
                          
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF0760FB),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x12344054),
                                blurRadius: 2,
                                offset: Offset(0, 1),
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
      ),
    );
  }
}
