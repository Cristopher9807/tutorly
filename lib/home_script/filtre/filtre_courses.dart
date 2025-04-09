import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FilteredCoursesScreen extends StatelessWidget {
  final String category;
  final String difficulty;
  final double minPrice;
  final double maxPrice;
  final int rating;
  final String published;
  final String duration;

  const FilteredCoursesScreen({
    Key? key,
    required this.category,
    required this.difficulty,
    required this.minPrice,
    required this.maxPrice,
    required this.rating,
    required this.published,
    required this.duration,
  }) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchFilteredCourses() async {
    Query query = FirebaseFirestore.instance.collection('courses')
      .where('category', isEqualTo: category)
      .where('difficulty', isEqualTo: difficulty)
      .where('published', isEqualTo: published)
      .where('duration', isEqualTo: duration)
      .where('price', isGreaterThanOrEqualTo: minPrice)
      .where('price', isLessThanOrEqualTo: maxPrice)
      .where('rating', isGreaterThanOrEqualTo: rating);

    final snapshot = await query.get();

    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cursos filtrados")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchFilteredCourses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No se encontraron cursos."));
          }

          final courses = snapshot.data!;

          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return Card(
                child: ListTile(
                  title: Text(course['title'] ?? 'Sin título'),
                  subtitle: Text(
                    "Categoría: ${course['category']} • "
                    "Dificultad: ${course['difficulty']}\n"
                    "Duración: ${course['duration']}, Publicado: ${course['published']}\n"
                    "Precio: \$${course['price']}",
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (i) {
                      return Icon(
                        i < (course['rating'] ?? 0)
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.orange,
                        size: 16,
                      );
                    }),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
