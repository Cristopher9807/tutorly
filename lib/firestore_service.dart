import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<void> uploadTutorsWithCourses() async {
  final tutors = [
    {
      "email": "pedroexample@gmail.com",
      "data": {
        "fullName": "Pedro Castillo",
        "email": "pedroexample@gmail.com",
        "phone": "+1 0000000000",
        "role": "tutor",
        "specialty": "Ingeniería Informática",
        "university": "Universidad Nacional",
        "universityId": "0000000"
      },
      "courses": [
        {
          "title": "Lógica Computacional y Resolución de Problemas",
          "instructor": "Pedro Castillo",
          "duration": "2h",
          "price": 20.0,
          "originalPrice": 35.0,
          "rating": 4.8,
          "numRatings": 600,
          "image": "https://img.freepik.com/fotos-premium/codificacion-lenguaje-programacion-computadora-portatil_95891-4532.jpg",
          "category": "Ingeniería",
          "difficulty": "Intermedio",
          "subject": "MAT 116",
          "availableDays": ["Lunes", "Miércoles"],
          "minPrice": 15,
          "maxPrice": 25,
          "experience": "1-3 Años",
          "degree": "Maestría en Matemáticas Aplicadas",
          "time": "Tarde",
          "published": "2025-04-01"
        }
      ]
    },
    {
      "email": "julia.anatole@gmail.com",
      "data": {
        "fullName": "Julia Anatole",
        "email": "julia.anatole@gmail.com",
        "phone": "+1 1010101010",
        "role": "tutor",
        "specialty": "Desarrollo Web",
        "university": "Instituto Tecnológico Global",
        "universityId": "0011001"
      },
      "courses": [
        {
          "title": "Técnicas avanzadas de programación front-end",
          "instructor": "Julia Anatole",
          "duration": "1h",
          "price": 14.99,
          "originalPrice": 29.99,
          "rating": 4.9,
          "numRatings": 1500,
          "image": "https://img.freepik.com/fotos-premium/sistema-html-concepto-sitio-web_23-2150376778.jpg",
          "category": "Desarrollo Web",
          "difficulty": "Intermedio",
          "subject": "WEB 201",
          "availableDays": ["Lunes", "Viernes"],
          "minPrice": 10,
          "maxPrice": 30,
          "experience": "3-5 Años",
          "degree": "Maestría en Ingeniería Web",
          "time": "Tarde",
          "published": "2025-03-20"
        }
      ]
    },
    {
      "email": "jacob.jones@gmail.com",
      "data": {
        "fullName": "Jacob Jones",
        "email": "jacob.jones@gmail.com",
        "phone": "+1 2223334444",
        "role": "tutor",
        "specialty": "Seguridad Informática",
        "university": "CyberTech Institute",
        "universityId": "9988776"
      },
      "courses": [
        {
          "title": "Fundamentos de ciberseguridad",
          "instructor": "Jacob Jones",
          "duration": "3h 25m",
          "price": 19.99,
          "originalPrice": 39.99,
          "rating": 4.9,
          "numRatings": 1800,
          "image": "https://img.freepik.com/fotos-premium/dos-administradores-sistema-centro-datos_236854-41074.jpg",
          "category": "Ciberseguridad",
          "difficulty": "Básico",
          "subject": "SEC 101",
          "availableDays": ["Martes", "Jueves"],
          "minPrice": 15,
          "maxPrice": 40,
          "experience": "5+ Años",
          "degree": "Doctorado en Seguridad Informática",
          "time": "Mañana",
          "published": "2025-03-15"
        }
      ]
    },
    {
      "email": "lucia.fernandez@gmail.com",
      "data": {
        "fullName": "Lucía Fernández",
        "email": "lucia.fernandez@gmail.com",
        "phone": "+1 5556667777",
        "role": "tutor",
        "specialty": "Ciencia de Datos y UX/UI",
        "university": "Universidad Técnica de México",
        "universityId": "1234567"
      },
      "courses": [
        {
          "title": "Programación en Python para análisis de datos",
          "instructor": "Lucía Fernández",
          "duration": "2h 45m",
          "price": 13.49,
          "originalPrice": 20.99,
          "rating": 4.9,
          "numRatings": 2000,
          "image": "https://img.freepik.com/fotos-premium/joven-africano-camisa-jeans-desarrollador-ti-que-presenta-programa-pantallas-computadora-que-muestran-datos-codificados-aplicacion-sitio-web-creando-innovadora-version-software-actualizada-tastemaker_31965-233009.jpg?w=360",
          "category": "Ciencia de Datos",
          "difficulty": "Intermedio",
          "subject": "DAT 204",
          "availableDays": ["Lunes", "Miércoles"],
          "minPrice": 10,
          "maxPrice": 25,
          "experience": "3-5 Años",
          "degree": "Maestría en Inteligencia Artificial",
          "time": "Noche",
          "published": "2025-03-05"
        },
        {
          "title": "Introducción al diseño UX/UI Moderno",
          "instructor": "Lucía Fernández",
          "duration": "1h 45m",
          "price": 12.99,
          "originalPrice": 25.99,
          "rating": 4.9,
          "numRatings": 2000,
          "image": "https://virtual.javerianacali.edu.co/images/diplomado-en-diseno-ux-1024x539_980w.webp",
          "category": "Diseño",
          "difficulty": "Básico",
          "subject": "UXD 101",
          "availableDays": ["Miércoles", "Viernes"],
          "minPrice": 10,
          "maxPrice": 30,
          "experience": "3-5 Años",
          "degree": "Maestría en Experiencia de Usuario",
          "time": "Tarde",
          "published": "2025-02-28"
        }
      ]
    },
    {
      "email": "eleanor.pena@gmail.com",
      "data": {
        "fullName": "Eleanor Peña",
        "email": "eleanor.pena@gmail.com",
        "phone": "+1 1112223333",
        "role": "tutor",
        "specialty": "Fotografía y Edición",
        "university": "Academia de Artes Visuales",
        "universityId": "4455667"
      },
      "courses": [
        {
          "title": "Introducción a la fotografía y edición",
          "instructor": "Eleanor Pena",
          "duration": "2h 30m",
          "price": 14.99,
          "originalPrice": 29.99,
          "rating": 4.8,
          "numRatings": 1500,
          "image": "https://img.freepik.com/fotos-premium/mujer-corriendo-negocios-linea-haciendo-velas-boutique-tomando-fotos-marketing-linea_562859-2724.jpg",
          "category": "Fotografía",
          "difficulty": "Básico",
          "subject": "FOT 100",
          "availableDays": ["Sábado"],
          "minPrice": 10,
          "maxPrice": 30,
          "experience": "5+ Años",
          "degree": "Licenciatura en Fotografía Profesional",
          "time": "Tarde",
          "published": "2025-02-02"
        }
      ]
    },
  ];

  // Itera sobre cada tutor
  for (final tutor in tutors) {
    final email = tutor["email"] as String;
    final data = tutor["data"] as Map<String, dynamic>;
    final courses = tutor["courses"] as List<Map<String, dynamic>>;

    // Guarda los datos del tutor
    final docRef = _firestore.collection("tutors").doc(email);
    await docRef.set(data);

    // Guarda los cursos del tutor en su subcolección de cursos
    for (final course in courses) {
      await docRef.collection("courses").add(course);
    }
  }

  print("✅ Todos los tutores y cursos fueron subidos correctamente.");
}
