import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FilteredCoursesScreen extends StatelessWidget {
  final String category;
  final String difficulty;
  final double minPrice;
  final double maxPrice;
  final double rating;
  final String published;
  final List<String> duration;

  const FilteredCoursesScreen({
    Key? key,
    required this.category,
    required this.difficulty,
    required this.minPrice,
    required this.maxPrice,
    required this.published,
    required this.rating,
    required this.duration,
  }) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchFilteredCourses() async {
    List<Map<String, dynamic>> filteredCourses = [];

    final tutorsSnapshot = await FirebaseFirestore.instance.collection('tutors').get();

    for (var tutorDoc in tutorsSnapshot.docs) {
      final coursesSnapshot = await tutorDoc.reference.collection('courses')
        .where('category', isEqualTo: category)
        .where('difficulty', isEqualTo: difficulty)
        .where('published', isEqualTo: published) // Filtra por si el curso está publicado
        .where('rating', isGreaterThanOrEqualTo: rating)
        .where('minPrice', isLessThanOrEqualTo: maxPrice)
        .where('maxPrice', isGreaterThanOrEqualTo: minPrice)
        .get();

      for (var courseDoc in coursesSnapshot.docs) {
        final courseData = courseDoc.data();
        courseData['tutorId'] = tutorDoc.id;
        courseData['courseId'] = courseDoc.id;
        courseData['tutorName'] = tutorDoc.data()['fullName'];

        // Filtrar por duración si es necesario
        if (duration.contains(courseData['duration'])) {
          filteredCourses.add(courseData);
        }
      }
    }

    return filteredCourses;
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
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No se encontraron cursos que coincidan."));
          }

          final courses = snapshot.data!;

          return ListView.builder(
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return ListTile(
                title: Text(course['subject'] ?? 'Sin título'),
                subtitle: Text('${course['category']} - ${course['difficulty']}'),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('\$${course['price']}'),
                    Text('${course['rating']} ⭐'),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}