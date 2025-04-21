import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Asegúrate de agregar intl en pubspec.yaml

class MyAppointmentsWidget extends StatelessWidget {
  const MyAppointmentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String? tutorId = FirebaseAuth.instance.currentUser?.email;

    if (tutorId == null) {
      return const Center(child: Text("No has iniciado sesión"));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('appointments')
          .where('tutorId', isEqualTo: tutorId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No tienes citas programadas"));
        }

        final citas = snapshot.data!.docs;

        return ListView.builder(
          itemCount: citas.length,
          itemBuilder: (context, index) {
            final data = citas[index].data() as Map<String, dynamic>;

            final studentName = data['studentName'] ?? 'Estudiante';
            final courseName = data['courseName'] ?? 'Curso';
            final startTime = (data['startTime'] as Timestamp?)?.toDate();
            final endTime = (data['endTime'] as Timestamp?)?.toDate();

            // Formatear las fechas
            final formattedStartTime = startTime != null
                ? DateFormat('dd MMM yyyy, hh:mm a').format(startTime)
                : 'Fecha no disponible';
            final formattedEndTime = endTime != null
                ? DateFormat('dd MMM yyyy, hh:mm a').format(endTime)
                : 'Fecha no disponible';

            final avatarUrl = data['avatarUrl'];
            final imageProvider = (avatarUrl != null && avatarUrl.toString().startsWith('http'))
                ? NetworkImage(avatarUrl)
                : const AssetImage('assets/user.png') as ImageProvider;

            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: imageProvider,
                    radius: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(studentName, style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text(courseName, style: const TextStyle(color: Colors.grey)),
                        Text('Inicio: $formattedStartTime', style: const TextStyle(color: Colors.grey)),
                        Text('Fin: $formattedEndTime', style: const TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  const Text("Pendiente", style: TextStyle(color: Colors.green))
                ],
              ),
            );
          },
        );
      },
    );
  }
}
