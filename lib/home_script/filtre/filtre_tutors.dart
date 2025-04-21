import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FilteredTutorsScreen extends StatelessWidget {
  final String subject;
  final List<String> availableDays;
  final List<String> time;
  final String experience;
  final String degree;
  final double minPrice;
  final double maxPrice;
  final double rating;

  const FilteredTutorsScreen({
    Key? key,
    required this.subject,
    required this.availableDays,
    required this.time,
    required this.experience,
    required this.degree,
    required this.minPrice,
    required this.maxPrice,
    required this.rating,
  }) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchFilteredTutors() async {
    List<Map<String, dynamic>> filteredTutors = [];

    final tutorsSnapshot = await FirebaseFirestore.instance.collection('tutors').get();

    for (var tutorDoc in tutorsSnapshot.docs) {
      final coursesSnapshot = await tutorDoc.reference.collection('courses')
        .where('category', isEqualTo: subject)  // Filtra por categoría o materia
        .where('difficulty', isEqualTo: experience)  // Filtra por experiencia
        .where('degree', isEqualTo: degree)  // Filtra por el grado
        .where('price', isGreaterThanOrEqualTo: minPrice)  // Filtra por precio mínimo
        .where('price', isLessThanOrEqualTo: maxPrice)  // Filtra por precio máximo
        .where('rating', isGreaterThanOrEqualTo: rating)  // Filtra por rating
        .get();

      for (var courseDoc in coursesSnapshot.docs) {
        final courseData = courseDoc.data();
        final availableDays = List<String>.from(courseData['availableDays'] ?? []);
        final courseTime = courseData['time'] ?? '';

        // Filtra por disponibilidad de días y horario
        final matchDay = availableDays.any((day) => this.availableDays.contains(day));
        final matchTime = courseTime == this.time;

        if (matchDay && matchTime) {
          filteredTutors.add({
            'fullName': tutorDoc['fullName'],
            'specialty': tutorDoc['specialty'],
            'price': courseData['price'],
            'rating': courseData['rating'],
            'courseTitle': courseData['title'],
            'tutorId': tutorDoc.id,
          });
        }
      }
    }

    return filteredTutors;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tutores filtrados")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchFilteredTutors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No se encontraron tutores que coincidan."));
          }

          final tutors = snapshot.data!;

          return ListView.builder(
            itemCount: tutors.length,
            itemBuilder: (context, index) {
              final tutor = tutors[index];
              return ListTile(
                title: Text(tutor['fullName'] ?? 'Sin nombre'),
                subtitle: Text('${tutor['specialty']} - ${tutor['courseTitle']}'),
                trailing: Text('\$${tutor['price']}'),
              );
            },
          );
        },
      ),
    );
  }
}