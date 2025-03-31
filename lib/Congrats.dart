import 'package:flutter/material.dart';
import 'home_script/home_screen.dart';

class Congrats extends StatefulWidget {
  const Congrats({super.key});

  @override
  CongratsState createState() => CongratsState();
}

class CongratsState extends State<Congrats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Permite que el contenido sea desplazable en pantallas pequeñas
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              children: [
                // Imagen de confeti
                SizedBox(
                  width: double.infinity,
                  child: Image.network(
                    "https://storage.googleapis.com/tagjs-prod.appspot.com/VuZ5hgGxQ3/r21o6dv4.png", 
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Check verde
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Image.asset(
                  'assets/circle.png', 
                  fit: BoxFit.fill,
                ),
                ),
                const SizedBox(height: 20),
                
                // Texto "¡Felicitaciones!"
                const Text(
                  "¡Felicitaciones!",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 14),
                
                // Texto de descripción
                const Text(
                  "Has ingresado correctamente. Ve a la página de inicio y empieza a explorar los cursos.",
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                
                // Botón "Ir a Inicio" (comentado la navegación)
                InkWell(
                  onTap: () {
                    Navigator.push(
                       context,
                       MaterialPageRoute(builder: (_) => HomeScreen()),
                     );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF0760FB),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        "Ir a Inicio",
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
