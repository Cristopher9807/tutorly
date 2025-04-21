import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorly/home_script/menu/notifications.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Asegúrate de que esto está
  runApp(MyApp());
}


class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  _CreateCourseScreenState createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String category = '';
  String description = '';
  String degree = '';
  String difficulty = '';
  String duration = '';
  String experience = '';
  String instructor = '';
  String subject = '';
  String time = '';
  String image = ''; // URL de la imagen
  double price = 0;
  double minPrice = 0;
  double maxPrice = 0;
  String published = ''; // Fecha de publicación
  int numRatings = 0;
  int rating = 0;
  List<String> availableDays = [];
  List<List<String>> chunkedDays = [
    ['Lunes', 'Martes', 'Miércoles'],
    ['Jueves', 'Viernes', 'Sábado'],
  ];

  // Métodos para manejar los días disponibles
  void toggleDay(String day) {
    setState(() {
      if (availableDays.contains(day)) {
        availableDays.remove(day);
      } else {
        availableDays.add(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear Curso"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Título del curso',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa el título del curso';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() => title = value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Categoría',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la categoría del curso';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() => category = value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa la descripción del curso';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() => description = value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Grado',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  onChanged: (value) => setState(() => degree = value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Dificultad',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  onChanged: (value) => setState(() => difficulty = value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Duración',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  onChanged: (value) => setState(() => duration = value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Experiencia requerida',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  onChanged: (value) => setState(() => experience = value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Instructor',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  onChanged: (value) => setState(() => instructor = value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Materia',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  onChanged: (value) => setState(() => subject = value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Hora del curso',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  onChanged: (value) => setState(() => time = value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Imagen (URL)',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  onChanged: (value) => setState(() => image = value),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Precio',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => setState(() => price = double.tryParse(value) ?? 0),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Precio mínimo',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => setState(() => minPrice = double.tryParse(value) ?? 0),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Precio máximo',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) => setState(() => maxPrice = double.tryParse(value) ?? 0),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Fecha de publicación',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  ),
                  onChanged: (value) => setState(() => published = value),
                ),
                const SizedBox(height: 20),

                // Título "Días disponibles:"
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Días disponibles:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // Días disponibles en filas de 3
                ...chunkedDays.map((chunk) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: chunk.map((day) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ChoiceChip(
                          label: Text(day),
                          selected: availableDays.contains(day),
                          onSelected: (_) => toggleDay(day),
                          selectedColor: Colors.blue,
                          labelStyle: TextStyle(
                            color: availableDays.contains(day)
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }).toList(),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async{
                    if (_formKey.currentState?.validate() ?? false) {
                      final currentUserEmail = FirebaseAuth.instance.currentUser?.email;

                    if (currentUserEmail != null) {
                      final courseData = {
                        'title': title,
                        'category': category,
                        'description': description,
                        'degree': degree,
                        'difficulty': difficulty,
                        'duration': duration,
                        'experience': experience,
                        'instructor': instructor,
                        'subject': subject,
                        'time': time,
                        'image': image,
                        'price': price,
                        'minPrice': minPrice,
                        'maxPrice': maxPrice,
                        'published': published,
                        'numRatings': numRatings,
                        'rating': rating,
                        'availableDays': availableDays,
                        'createdAt': FieldValue.serverTimestamp(),
                      };

                      await FirebaseFirestore.instance
                          .collection('tutors')
                          .doc(currentUserEmail)
                          .collection('courses')
                          .add(courseData);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Curso creado con éxito')),
                      );

                      // Opcional: limpiar el formulario
                      _formKey.currentState?.reset();
                      setState(() {
                        availableDays.clear();
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No se encontró el usuario')),
                      );
                    }

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Curso creado con éxito')),
                      );
                    }
                  },
                  child: const Text(
                    'Crear Curso',
                    style: TextStyle(color: Colors.white), // Texto blanco
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 30), // Tamaño más pequeño
                    padding: const EdgeInsets.symmetric(vertical: 10), // Reducción del padding
                    textStyle: const TextStyle(fontSize: 16), // Tamaño de la letra más pequeño
                    shadowColor: Colors.blueAccent,
                    elevation: 3, // Sombra más suave
                    backgroundColor: Colors.blue, // Color del fondo
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
