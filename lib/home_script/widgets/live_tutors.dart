import 'package:flutter/material.dart';

class LiveTutorsSection extends StatelessWidget {
  final List<Map<String, dynamic>> tutors = [
    {
      "name": "Carlos Méndez",
      "subjectCode": "CS101",
      "image": "https://randomuser.me/api/portraits/men/32.jpg",
    },
    {
      "name": "Andrea López",
      "subjectCode": "SEC202",
      "image": "https://randomuser.me/api/portraits/women/45.jpg",
    },
    {
      "name": "Miguel Rodríguez",
      "subjectCode": "FLTR300",
      "image": "https://randomuser.me/api/portraits/men/50.jpg",
    },
    {
      "name": "Laura Fernández",
      "subjectCode": "ML420",
      "image": "https://randomuser.me/api/portraits/women/60.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Los mejores tutores en vivo de la semana',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 140, // 🔹 Altura suficiente para mostrar cada tutor centrado
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // 📌 Scroll horizontal
              itemCount: tutors.length,
              itemBuilder: (context, index) {
                return _buildTutorCard(tutors[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorCard(Map<String, dynamic> tutor) {
    return Container(
      width: 120, // 📌 Ancho de cada tarjeta
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
        mainAxisAlignment: MainAxisAlignment.center, // 🔹 Todo centrado verticalmente
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40), // 🔹 Imagen circular
            child: Image.network(
              tutor["image"],
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tutor["name"],
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            tutor["subjectCode"], // 📌 Código de la asignatura
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
