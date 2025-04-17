import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LiveTutorsSection extends StatefulWidget {
  @override
  _LiveTutorsSectionState createState() => _LiveTutorsSectionState();
}

class _LiveTutorsSectionState extends State<LiveTutorsSection> {
  Future<List<Map<String, dynamic>>> _fetchTutors() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('tutors').get();

    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return {
        "name": data['fullName'] ?? 'Sin nombre',
        "subjectCode": data['specialty'] ?? 'N/A',
        "image": data['image'] ??
            'https://cdn-icons-png.flaticon.com/512/194/194935.png', // imagen por defecto
      };
    }).toList();
  }

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
            height: 140,
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: _fetchTutors(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error al cargar tutores.'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay tutores disponibles.'));
                }

                final tutors = snapshot.data!;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tutors.length,
                  itemBuilder: (context, index) {
                    return _buildTutorCard(tutors[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorCard(Map<String, dynamic> tutor) {
    return Container(
      width: 120,
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40),
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
            tutor["subjectCode"],
            style: const TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
