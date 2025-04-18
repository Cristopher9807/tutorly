import 'package:flutter/material.dart';

class TutorDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> tutor;

  const TutorDetailsScreen({super.key, required this.tutor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tutor['name']),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(tutor),
            _buildEducation(tutor),
            _buildReviews(tutor),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí luego va la lógica de reservar o contactar
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Resérvame'),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Map<String, dynamic> tutor) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(tutor['image']),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tutor['name'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(tutor['university'], style: const TextStyle(color: Colors.grey)),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 16),
                    Text('${tutor['rating']} (${tutor['reviews']})'),
                  ],
                ),
              ],
            ),
          ),
          Text(
            tutor['price'],
            style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildEducation(Map<String, dynamic> tutor) {
    final education = tutor['education'] ?? [];
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Educación", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          ...education.map<Widget>((item) {
            return ListTile(
              leading: const Icon(Icons.school),
              title: Text(item['degree']),
              subtitle: Text(item['institution']),
              trailing: Text(item['year']),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildReviews(Map<String, dynamic> tutor) {
    final reviews = tutor['reviewsList'] ?? [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Reseñas", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 12),
          ...reviews.map<Widget>((review) {
            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(review['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(review['date']),
                  const SizedBox(height: 4),
                  Text(review['comment']),
                ],
              ),
              trailing: const Icon(Icons.star, color: Colors.orange),
            );
          }).toList(),
        ],
      ),
    );
  }
}
