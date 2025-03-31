import 'package:flutter/material.dart';
import 'widgets/home_header.dart'; // Importa el header
import 'widgets/courses_page.dart'; // Importa la página de cursos
import 'widgets/live_tutors.dart';
import 'widgets/new_courses.dart';
import 'menu/side_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(), // 📌 Agrega el menú lateral aquí
      appBar: AppBar(
        title: const Text("Tutorly"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 35),
            const HomeHeader(), 
            CoursesPage(), 
            LiveTutorsSection(),
            BestNewCourses(),
          ],
        ),
      ),
    );
  }
}
