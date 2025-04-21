// Archivo: widgets/my_courses_widget.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tutorly/user_session.dart';

class MyCoursesWidget extends StatelessWidget {
  const MyCoursesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('tutors')
          .doc(UserSession.email) // Asegúrate de guardar el email al hacer login
          .collection('courses')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("Aún no tienes cursos publicados."));
        }

        final courses = snapshot.data!.docs;

        return ListView.builder(
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index].data() as Map<String, dynamic>;
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                title: Text(course['subject'] ?? 'Sin asignatura'),
                subtitle: Text("Nivel: ${course['difficulty'] ?? 'N/A'}"),
                trailing: Text("\$${course['minPrice']} - \$${course['maxPrice']}"),
              ),
            );
          },
        );
      },
    );
  }
}
