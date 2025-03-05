import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Email.dart'; // Pantalla a la que regresa el botón "Atrás"
import 'UploadPhoto.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  EducationState createState() => EducationState();
}

class EducationState extends State<Education> {
  // Controlador para el campo de Identificación universitaria
  final TextEditingController idController = TextEditingController();

  // Variables para los dropdowns
  String selectedSpecialty = "Ingeniería Informática";
  String selectedUniversity = "Harvard University";

  // Listado de especialidades
  final List<String> specialties = [
    "Ingeniería Informática",
    "Ingeniería Industrial",
    "Medicina",
    "Arquitectura",
    "Derecho",
    "Economía",
    "Psicología",
    "Biología",
    "Química",
    "Física",
    "No encuentro mi Especialidad",
  ];

  // Listado de universidades (de España, Rep. Dom, EEUU, México y Canadá)
  final List<String> universities = [
    "Harvard University",
    "Stanford University",
    "Massachusetts Institute of Technology",
    "Universidad Autónoma de Santo Domingo",
    "Pontificia Universidad Católica Madre y Maestra",
    "Universidad Nacional Autónoma de México",
    "Instituto Tecnológico y de Estudios Superiores de Monterrey",
    "University of Toronto",
    "University of British Columbia",
    "Universidad de Barcelona",
    "Universidad Complutense de Madrid",
    "No encuentro mi Institución",
  ];

  // La forma es válida si el campo de identificación no está vacío.
  bool get isFormValid => idController.text.isNotEmpty &&
      selectedSpecialty.isNotEmpty &&
      selectedUniversity.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Permite desplazarse en pantallas pequeñas
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Botón "Atrás" en azul, que lleva a Email.dart
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const Email()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.arrow_back, color: Colors.blue),
                      SizedBox(width: 8),
                      Text(
                        "Atrás",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Título y subtítulo
                const Text(
                  "Tu educación",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Proporcione su información educativa",
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 30),

                // Campo: Identificación universitaria (solo números)
                const Text(
                  "Identificación universitaria",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  child: TextField(
                    controller: idController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      hintText: "Solo números",
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {}); // Actualiza la validez del formulario
                    },
                  ),
                ),
                const SizedBox(height: 20),

                // Dropdown: Especialidad
                const Text(
                  "Especialidad",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedSpecialty,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSpecialty = newValue!;
                        });
                      },
                      items: specialties.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(fontSize: 14)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Dropdown: Universidad
                const Text(
                  "Universidad",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedUniversity,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedUniversity = newValue!;
                        });
                      },
                      items: universities.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value, style: const TextStyle(fontSize: 14)),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Botón "Continuar" (activo solo si el campo de identificación no está vacío)
                InkWell(
                  onTap: isFormValid
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const UploadPhoto()),
                          );
                        }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isFormValid ? const Color(0xFF0760FB) : Colors.grey,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "Continuar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Barra decorativa inferior (opcional)
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xFFE2E8F0),
                    ),
                    width: 132,
                    height: 6,
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
