import 'package:flutter/material.dart';
import 'package:tutorly/congrats.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Barra de búsqueda
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {},
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(14),
              ),
            ),
          ),
        ),

        const SizedBox(height: 30),

        // Sección "Tutoría en vivo"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Tutoría en vivo",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  // Navega a la pantalla de "Todas las materias"
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Congrats()), // Define la nueva pantalla aquí
                  );
                },
                child: const Text(
                  "Todas las materias >",
                  style: TextStyle(fontSize: 14, color: Colors.blue), // Estilo azul para el texto
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 10),

        // Tarjetas de Tutoría en vivo
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              _buildLiveCard(
                title: "Mat 116",
                subtitle: "19 Tutor",
                color1: Colors.red,
                color2: Colors.orange,
              ),
              const SizedBox(width: 10),
              _buildLiveCard(
                title: "Arqui 116",
                subtitle: "15 Tutor",
                color1: const Color.fromARGB(255, 0, 109, 199),
                color2: Colors.blueAccent,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // Banner de oferta
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: const LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Obtén la oferta de tu ",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () {
                          // TODO: Navegación a otra pantalla
                        },
                        child: const Text(
                          "vida",
                          style: TextStyle(
                            color: Colors.yellow,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text(
                        "Acceso a todos los cursos",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text("Canjear ahora", style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Image.network(
                  "https://storage.googleapis.com/tagjs-prod.appspot.com/VuZ5hgGxQ3/r21o6dv4.png",
                  width: 80,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLiveCard({
    required String title,
    required String subtitle,
    required Color color1,
    required Color color2,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(colors: [color1, color2]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
