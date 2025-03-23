import 'package:flutter/material.dart';
// IMPORTA TUS PANTALLAS REALES:
import 'role_separator.dart';
import 'Onboarding3.dart';

class Onboarding2 extends StatefulWidget {
  const Onboarding2({Key? key}) : super(key: key);

  @override
  Onboarding2State createState() => Onboarding2State();
}

class Onboarding2State extends State<Onboarding2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),

              // --- IMAGEN PRINCIPAL ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Image.asset(
                  'assets/image.png', // Ajusta la ruta si es distinta
                  fit: BoxFit.fill,
                ),
              ),

              const SizedBox(height: 24),

              // --- TÍTULO ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 44),
                child: Text(
                  "Encuentra el apoyo que necesitas",
                  style: const TextStyle(
                    color: Color(0xFF0760FB),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),

              // --- DESCRIPCIÓN ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 34),
                child: Text(
                  "Encuentra el tutor ideal para cada materia y resuelve tus dudas con sesiones personalizadas.",
                  style: const TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),

              // --- INDICADOR (DOTS) ---
              SizedBox(
                width: 44,
                height: 8,
                child: Image.network(
                  "https://storage.googleapis.com/tagjs-prod.appspot.com/VuZ5hgGxQ3/779zff6b.png",
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: 30),

              // --- BOTONES "SALTAR" Y "CONTINUAR" ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Botón "Saltar"
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const RoleSeparator()),
                        );
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

                    // Botón "Continuar"
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const Onboarding3()),
                        );
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
