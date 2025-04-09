import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ratings & Reviews',
      home: RatingsAndReviewsScreen(),
    );
  }
}

class RatingsAndReviewsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ratings & Reviews'),
      ),
      body: ListView(
        children: [
          ReviewCard(
            name: 'Arlene McCoy',
            rating: 4.5,
            review: 'Arlene McCoy es un tutor en vivo excepcional. Su experiencia y paciencia hicieron que el aprendizaje fuera agradable y productivo, Me brindo comentarios en tiempo real que mejoraron enormemente mi comprensión de conceptos complejos. ¡ Muy recomendable!"',
            date: '24 Aug 2023',
          ),
          ReviewCard(
            name: 'Introducción a la fotografía y edición',
            rating: 4.5,
            review: 'El curso de "Introducción a la fotografia y la edición" fue fantástico. Abarcó todo, desde los ajustes básicos de la cámara hasta las técnicas de edición avanzadas. Perfecto tanto para fotógrafos principiantes como intermedios".',
            date: '24 Aug 2023',
          ),
          ReviewCard(
            name: 'Inteligencia artificial con Python',
            rating: 4.5,
            review: '"El curso sobre inteligencia artificial con Python fue bueno, pero senti que podria haber profundizado más en algunos de los temas avanzados. Los proyectos prácticos fueron útiles, pero las explicaciones a veces carecian de detalles. Aun asi, es una introducción decente a la IA con Python".',
            date: '24 Aug 2023',
          ),
        ],
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final String name;
  final double rating;
  final String review;
  final String date;

  ReviewCard({
    required this.name,
    required this.rating,
    required this.review,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                Text(
                  rating.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(review),
            SizedBox(height: 8.0),
            Text(
              date,
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
