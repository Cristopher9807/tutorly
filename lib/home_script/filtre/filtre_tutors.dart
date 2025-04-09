import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FilteredTutorsScreen extends StatelessWidget {
  final String subject;
  final List<String> availableDays;
  final double minPrice;
  final double maxPrice;
  final int rating;
  final String experience;
  final String degree;
  final String time;

  const FilteredTutorsScreen({
    Key? key,
    required this.subject,
    required this.availableDays,
    required this.minPrice,
    required this.maxPrice,
    required this.rating,
    required this.experience,
    required this.degree,
    required this.time,
  }) : super(key: key);

  Future<List<Map<String, dynamic>>> fetchFilteredTutors() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('tutors')
        .where('subject', isEqualTo: subject)
        .where('experience', isEqualTo: experience)
        .where('degree', isEqualTo: degree)
        .where('time', isEqualTo: time)
        .where('rating', isGreaterThanOrEqualTo: rating)
        .where('price', isGreaterThanOrEqualTo: minPrice)
        .where('price', isLessThanOrEqualTo: maxPrice)
        .get();

    final filtered = querySnapshot.docs.where((doc) {
      final tutor = doc.data();
      return availableDays.any((day) => (tutor['availableDays'] as List).contains(day));
    }).map((doc) => doc.data() as Map<String, dynamic>).toList();

    return filtered;
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
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No se encontraron tutores."));
          }

          final tutors = snapshot.data!;

          return ListView.builder(
            itemCount: tutors.length,
            itemBuilder: (context, index) {
              final tutor = tutors[index];
              return Card(
                child: ListTile(
                  title: Text(tutor['name'] ?? 'Sin nombre'),
                  subtitle: Text("Materia: ${tutor['subject']}, Precio: \$${tutor['price']}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (i) {
                      return Icon(
                        i < (tutor['rating'] ?? 0)
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
