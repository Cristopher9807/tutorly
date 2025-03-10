/*import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Email.dart'; // Pantalla a la que regresa el botón "Atrás"
import 'UploadPhoto.dart';

class Education extends StatefulWidget {
  const Education({super.key});

  @override
  EducationState createState() => EducationState();
}

class EducationState extends State<Education> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController customSpecialtyController = TextEditingController();
  final TextEditingController customUniversityController = TextEditingController();

  String selectedSpecialty = "Ingeniería Informática";
  String selectedUniversity = "Harvard University";
  bool showCustomSpecialtyField = false;
  bool showCustomUniversityField = false;

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

  final List<String> universities = [
    "Harvard University",
    "Stanford University",
    "Massachusetts Institute of Technology",
    "Universidad Autónoma de Santo Domingo (UASD)",
    "Pontificia Universidad Católica Madre y Maestra (PUCMM)",
    "Universidad Nacional Pedro Henríquez Ureña (UNPHU)",
    "Instituto Tecnológico de Santo Domingo (INTEC)",
    "Universidad APEC (UNAPEC)",
    "Universidad Central del Este (UCE)",
    "Universidad Tecnológica de Santiago (UTESA)",
    "Universidad Católica Santo Domingo (UCSD)",
    "Universidad Iberoamericana (UNIBE)",
    "Universidad Nacional Evangélica (UNEV)",
    "Universidad Abierta para Adultos (UAPA)",
    "Universidad Católica Nordestana (UCNE)",
    "Universidad Católica Tecnológica de Barahona (UCATEBA)",
    "Universidad Federico Henríquez y Carvajal (UFHEC)",
    "Universidad Tecnológica del Sur (UTESUR)",
    "Universidad ISA",
    "Universidad Agroforestal Fernando Arturo de Meriño (UAFAM)",
    "Universidad Odontológica Dominicana (UOD)",
    "Universidad Eugenio María de Hostos (UNIREMHOS)",
    "Universidad Experimental Félix Adam (UNEFA)",
    "Universidad Nacional Tecnológica (UNNATEC)",
    "Universidad Psicología Industrial Dominicana (UPID)",
    "Universidad Dominicana Organización y Método (O&M)",
    "Universidad del Caribe (UNICARIBE)",
    "Universidad de la Tercera Edad (UTE)",
    "Universidad Interamericana (UNICA)",
    "Universidad Central Dominicana de Estudios Profesionales (UCDEP)",
    "Universidad Domínico-Americana (UNICDA)",
    "Universidad Adventista Dominicana (UNAD)",
    "Universidad Católica del Cibao (UCATECI)",
    "Instituto Tecnológico del Cibao Oriental (ITECO)",
    "Instituto Especializado de Estudios Superiores Loyola (IEESL)",
    "Instituto Tecnológico de Las Américas (ITLA)",
    "No encuentro mi Institución",
  ];

    bool get isFormValid =>
      idController.text.isNotEmpty &&
      selectedSpecialty.isNotEmpty &&
      selectedUniversity.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Botón "Atrás"
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
                    Text("Atrás", style: TextStyle(color: Colors.blue, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Título
              const Text(
                "Tu educación",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              // Subtítulo
              const Text(
                "Proporcione su información educativa",
                style: TextStyle(
                  fontSize: 17,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 30),

              // Campo: Identificación universitaria
              TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Identificación universitaria",
                  hintText: "189204 8923", // Como en la imagen
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 20),

              // Etiqueta "Especialidad"
              const Text(
                "Especialidad",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              // Dropdown: Especialidad
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedSpecialty,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSpecialty = newValue!;
                        showCustomSpecialtyField = newValue == "No encuentro mi Especialidad";
                      });
                    },
                    items: specialties.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              if (showCustomSpecialtyField) ...[
                const SizedBox(height: 8),
                TextField(
                  controller: customSpecialtyController,
                  decoration: InputDecoration(
                    hintText: "Ingrese su especialidad",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),

              // Etiqueta "Universidad"
              const Text(
                "Universidad",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              // Dropdown: Universidad
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedUniversity,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedUniversity = newValue!;
                        showCustomUniversityField = newValue == "No encuentro mi Institución";
                      });
                    },
                    items: universities.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              if (showCustomUniversityField) ...[
                const SizedBox(height: 8),
                TextField(
                  controller: customUniversityController,
                  decoration: InputDecoration(
                    hintText: "Ingrese su institución",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 30),

              // Botón "Continuar"
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: isFormValid
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const UploadPhoto()),
                          );
                        }
                      : null,
                  child: const Text(
                    "Continuar",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/









import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Email.dart';
import 'Congrats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Education extends StatefulWidget {
  final String phoneNumber; // Agrega el número de teléfono

  const Education({Key? key, required this.phoneNumber}) : super(key: key); // Modifica el constructor

  @override
  EducationState createState() => EducationState();
}

class EducationState extends State<Education> {
  final TextEditingController idController = TextEditingController();
  String selectedSpecialty = "Ingeniería Informática";
  String selectedUniversity = "Harvard University";
  bool showCustomSpecialtyField = false;
  bool showCustomUniversityField = false;

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

  final List<String> universities = [
    "Harvard University",
    "Stanford University",
    "Massachusetts Institute of Technology",
    "Universidad Autónoma de Santo Domingo (UASD)",
    "Pontificia Universidad Católica Madre y Maestra (PUCMM)",
    "Universidad Nacional Pedro Henríquez Ureña (UNPHU)",
    "Instituto Tecnológico de Santo Domingo (INTEC)",
    "Universidad APEC (UNAPEC)",
    "Universidad Central del Este (UCE)",
    "Universidad Tecnológica de Santiago (UTESA)",
    "Universidad Católica Santo Domingo (UCSD)",
    "Universidad Iberoamericana (UNIBE)",
    "Universidad Nacional Evangélica (UNEV)",
    "Universidad Abierta para Adultos (UAPA)",
    "Universidad Católica Nordestana (UCNE)",
    "Universidad Católica Tecnológica de Barahona (UCATEBA)",
    "Universidad Federico Henríquez y Carvajal (UFHEC)",
    "Universidad Tecnológica del Sur (UTESUR)",
    "Universidad ISA",
    "Universidad Agroforestal Fernando Arturo de Meriño (UAFAM)",
    "Universidad Odontológica Dominicana (UOD)",
    "Universidad Eugenio María de Hostos (UNIREMHOS)",
    "Universidad Experimental Félix Adam (UNEFA)",
    "Universidad Nacional Tecnológica (UNNATEC)",
    "Universidad Psicología Industrial Dominicana (UPID)",
    "Universidad Dominicana Organización y Método (O&M)",
    "Universidad del Caribe (UNICARIBE)",
    "Universidad de la Tercera Edad (UTE)",
    "Universidad Interamericana (UNICA)",
    "Universidad Central Dominicana de Estudios Profesionales (UCDEP)",
    "Universidad Domínico-Americana (UNICDA)",
    "Universidad Adventista Dominicana (UNAD)",
    "Universidad Católica del Cibao (UCATECI)",
    "Instituto Tecnológico del Cibao Oriental (ITECO)",
    "Instituto Especializado de Estudios Superiores Loyola (IEESL)",
    "Instituto Tecnológico de Las Américas (ITLA)",
    "No encuentro mi Institución",
  ];

  bool get isFormValid =>
      idController.text.isNotEmpty &&
      selectedSpecialty.isNotEmpty &&
      selectedUniversity.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => Email(phoneNumber: widget.phoneNumber)), // Pasa el número de teléfono
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.arrow_back, color: Colors.blue),
                    SizedBox(width: 8),
                    Text("Atrás", style: TextStyle(color: Colors.blue, fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const Text(
                "Tu educación",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              const Text(
                "Proporcione su información educativa",
                style: TextStyle(
                  fontSize: 17,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 30),

              TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: "Identificación universitaria",
                  hintText: "189204 8923",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 20),

              const Text(
                "Especialidad",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedSpecialty,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSpecialty = newValue!;
                        showCustomSpecialtyField = newValue == "No encuentro mi Especialidad";
                      });
                    },
                    items: specialties.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              if (showCustomSpecialtyField) ...[
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Ingrese su especialidad",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 20),

              const Text(
                "Universidad",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedUniversity,
                    isExpanded: true,
                    icon: const Icon(Icons.arrow_drop_down),
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedUniversity = newValue!;
                        showCustomUniversityField = newValue == "No encuentro mi Institución";
                      });
                    },
                    items: universities.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              if (showCustomUniversityField) ...[
                const SizedBox(height: 8),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Ingrese su institución",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: isFormValid
                      ? () async {
                          await FirebaseFirestore.instance.collection('users').doc(widget.phoneNumber).set({
                            'education': {
                              'universityID': idController.text,
                              'major': selectedSpecialty,
                              'university': selectedUniversity,
                            }
                          }, SetOptions(merge: true));
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Congrats()), // No necesita pasar el número de teléfono aquí
                          );
                        }
                      : null,
                  child: const Text(
                    "Continuar",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
