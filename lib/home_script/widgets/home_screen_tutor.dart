// Archivo: home_screen_tutor.dart
import 'package:flutter/material.dart';

class HomeScreenTutor extends StatefulWidget {
  const HomeScreenTutor({super.key});

  @override
  State<HomeScreenTutor> createState() => _HomeScreenTutorState();
}

class _HomeScreenTutorState extends State<HomeScreenTutor> {
  bool mostrarCursos = true;

  final List<Map<String, String>> citas = [
    {"nombre": "Eleanor Pena", "universidad": "Københavns Universitet", "avatar": "https://randomuser.me/api/portraits/women/1.jpg"},
    {"nombre": "Robert Fox", "universidad": "University of Oxford", "avatar": "https://randomuser.me/api/portraits/men/2.jpg"},
    {"nombre": "Dianne Russell", "universidad": "Syddansk Universitet", "avatar": "https://randomuser.me/api/portraits/women/3.jpg"},
    {"nombre": "Guy Hawkins", "universidad": "Aarhus Universitet", "avatar": "https://randomuser.me/api/portraits/men/4.jpg"},
    {"nombre": "Julia Anatole", "universidad": "Harvard Business School", "avatar": "https://randomuser.me/api/portraits/women/5.jpg"},
    {"nombre": "Albert Flores", "universidad": "Wake Forest University", "avatar": "https://randomuser.me/api/portraits/men/6.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // TODO: Abrir menú de navegación lateral
          },
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 0.5),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.notifications_none, color: Colors.black, size: 20),
              onPressed: () {
                // TODO: Abrir notificaciones
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 6),
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.add, color: Colors.black, size: 18),
              onPressed: () {
                // TODO: Acción al presionar el botón de añadir
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => mostrarCursos = true);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mostrarCursos ? Colors.blue : Colors.white,
                        foregroundColor: mostrarCursos ? Colors.white : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      child: const Text("Mis Cursos"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() => mostrarCursos = false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: mostrarCursos ? Colors.white : Colors.blue,
                        foregroundColor: mostrarCursos ? Colors.black : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: const BorderSide(color: Colors.black),
                        ),
                      ),
                      child: const Text("Citas"),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  mostrarCursos ? "Mis Cursos" : "Mis Citas",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (mostrarCursos)
                  GestureDetector(
                    onTap: () {
                      // TODO: Navegar a Todos los cursos
                    },
                    child: const Text("Todos los cursos", style: TextStyle(color: Colors.blue)),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: mostrarCursos
                  ? const Center(child: Text("Aquí se mostrarán tus cursos"))
                  : ListView.builder(
                      itemCount: citas.length,
                      itemBuilder: (context, index) {
                        final cita = citas[index];
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
                                backgroundImage: NetworkImage(cita["avatar"]!),
                                radius: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cita["nombre"]!,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      cita["universidad"]!,
                                      style: const TextStyle(color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              const Text("Pendiente", style: TextStyle(color: Colors.green))
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
