import 'package:flutter/material.dart';
import 'package:tutorly/congrats.dart';

class CoursesPage extends StatelessWidget {
  final List<Map<String, dynamic>> courses = [
    {
      "title": "Técnicas avanzadas de programación front-end",
      "instructor": "Julia Anatole",
      "duration": "1h",
      "price": 14.99,
      "originalPrice": 29.99,
      "rating": 4.9,
      "numRatings": 1500,
      "image": "https://img.freepik.com/fotos-premium/sistema-html-concepto-sitio-web_23-2150376778.jpg",
    },
    {
      "title": "Fundamentos de ciberseguridad",
      "instructor": "Jacob Jones",
      "duration": "3h 25m",
      "price": 19.99,
      "originalPrice": 39.99,
      "rating": 4.9,
      "numRatings": 1800,
      "image": "https://img.freepik.com/fotos-premium/dos-administradores-sistema-centro-datos_236854-41074.jpg",
    },
    {
      "title": "Programación en Python para análisis de datos",
      "instructor": "Lucía Fernández",
      "duration": "2h 45m",
      "price": 13.49,
      "originalPrice": 20.99,
      "rating": 4.9,
      "numRatings": 2000,
      "image": "https://img.freepik.com/fotos-premium/joven-africano-camisa-jeans-desarrollador-ti-que-presenta-programa-pantallas-computadora-que-muestran-datos-codificados-aplicacion-sitio-web-creando-innovadora-version-software-actualizada-tastemaker_31965-233009.jpg?w=360",
    },
  ];

  @override
    Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribuye los elementos horizontalmente
            children: [
              const Text(
                'Cursos de tendencia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  // Navega a otra pantalla
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Congrats()), // Define la nueva pantalla aquí
                  );
                },
                child: const Text(
                  'Todas las materias >',
                  style: TextStyle(fontSize: 14, color: Colors.blue), // Estilo azul del texto
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 230, // Espacio suficiente para mostrar las tarjetas
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Scroll horizontal
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return _buildCourseCard(courses[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return Container(
      width: 180, // 📌 Ancho de cada tarjeta
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)), 
            child: Image.network(
              course["image"], 
              height: 100, // 🔹 Altura de la imagen
              width: double.infinity,
              fit: BoxFit.cover, 
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0), 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course["title"],
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  '${course["instructor"]} • ${course["duration"]}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${course["price"]}', 
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                    if (course["originalPrice"] > course["price"])
                      Text('\$${course["originalPrice"]}',
                        style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey),
                      ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text('${course["rating"]} (${course["numRatings"]})', style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
