import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourseDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> courseData;

  CourseDetailsScreen({required this.courseData});

  @override
  Widget build(BuildContext context) {
    final title = courseData['title'] ?? 'Sin título';
    final degree = courseData['degree'] ?? 'Sin título académico';
    final description = courseData['description'] ?? 'Sin descripción';
    final image = courseData['image'] ?? 'https://via.placeholder.com/150';
    final rating = courseData['rating'] ?? 0.0;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 48, left: 16, right: 16),
            height: 160,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueAccent, Colors.lightBlueAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen + título
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.network(
                            image,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                              SizedBox(height: 4),
                              Text(degree, style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),

                  // Descripción
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(description, style: TextStyle(fontSize: 15)),
                  ),
                  SizedBox(height: 24),

                  // Tutores
                  Text("Tutores", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('tutors')
                        .where('fullName', isEqualTo: courseData['instructor'])
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                      final tutors = snapshot.data!.docs;
                      if (tutors.isEmpty) return Text('No se encontró el tutor.');

                      return ListView.builder(
                        itemCount: tutors.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final tutor = tutors[index].data() as Map<String, dynamic>;
                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundImage: NetworkImage(
                                    tutor['photoUrl'] ?? 'https://via.placeholder.com/100',
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(tutor['fullName'] ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(tutor['university'] ?? '', style: TextStyle(color: Colors.grey[600])),
                                      Row(
                                        children: [
                                          Icon(Icons.star, color: Colors.orange, size: 16),
                                          SizedBox(width: 4),
                                          Text('$rating', style: TextStyle(color: Colors.orange)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Text('\$${tutor['minPrice'] ?? 0}', style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
