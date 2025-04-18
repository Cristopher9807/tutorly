import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutorly/congrats.dart';
import 'package:tutorly/home_script/course_details_screen.dart';

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  List<Map<String, dynamic>> courses = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCoursesFromFirebase();
  }

  Future<void> fetchCoursesFromFirebase() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    List<Map<String, dynamic>> allCourses = [];

    try {
      final tutorsSnapshot = await firestore.collection('tutors').get();

      for (var tutorDoc in tutorsSnapshot.docs) {
        final coursesSnapshot = await tutorDoc.reference.collection('courses').get();

        for (var courseDoc in coursesSnapshot.docs) {
          final courseData = courseDoc.data();
          allCourses.add({
            "title": courseData["subject"] ?? "Curso sin título",
            "description": courseData["description"] ?? "Sin descripción",
            "degree": courseData["degree"] ?? "Sin título académico",
            "instructor": tutorDoc.data()["fullName"] ?? "Instructor desconocido",
            "duration": courseData["duration"] ?? "0h",
            "price": courseData["minPrice"] ?? 0.0,
            "originalPrice": courseData["maxPrice"] ?? 0.0,
            "rating": courseData["rating"] ?? 0.0,
            "numRatings": 100 + allCourses.length * 10,
            "image": courseData["image"] ?? "https://via.placeholder.com/150",
          });
        }
      }

      setState(() {
        courses = allCourses;
        isLoading = false;
      });
    } catch (e) {
      print("Error al obtener cursos: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 20.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cursos de tendencia',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Congrats()),
                  );
                },
                child: const Text(
                  'Todas las materias >',
                  style: TextStyle(fontSize: 14, color: Colors.blue),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          if (isLoading)
            const Center(child: CircularProgressIndicator())
          else if (courses.isEmpty)
            const Text("No hay cursos disponibles.")
          else
            SizedBox(
              height: 230,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: courses.length,
                itemBuilder: (context, index) {
                  return _buildCourseCard(courses[index]);
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CourseDetailsScreen(courseData: course),
          ),
        );
      },
      child: Container(
        width: 180,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                course["image"],
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course["title"],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${course["instructor"]} • ${course["duration"]}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$${course["price"]}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      if (course["originalPrice"] > course["price"])
                        Text('\$${course["originalPrice"]}',
                            style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text('${course["rating"]} (${course["numRatings"]})', style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
