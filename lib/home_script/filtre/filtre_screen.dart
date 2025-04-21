import 'package:flutter/material.dart';
import 'filtre_tutors.dart';
import 'filtre_courses.dart';

class FiltersScreen extends StatefulWidget {
  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool isTutorsSelected = true;
  double minRate = 0;
  double maxRate = 30;
  int selectedRating = 3;

  String selectedSubject = "MAT 116";
  String selectedExperience = "1-3 Años";
  String selectedDegree = "Maestría en Matemáticas Aplicadas";
  String selectedCategory = "Programación";
  String selectedLevel = "Principiante";
  String selectedPublished = "En los últimos 6 meses";
  List<String> selectedAvailability = [];
  List<String> selectedTime = [];
  List<String> selectedDuration = ["3-6 hrs"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filtros", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildToggleButtons(),
            const SizedBox(height: 20),
            isTutorsSelected ? _buildTutorFilters() : _buildCourseFilters(),
            const SizedBox(height: 20),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildToggleButton("Tutores", isTutorsSelected, () {
          setState(() => isTutorsSelected = true);
        }),
        _buildToggleButton("Cursos", !isTutorsSelected, () {
          setState(() => isTutorsSelected = false);
        }),
      ],
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTutorFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDropdown("Asignatura", selectedSubject, [
          "MAT 116", "Física", "Química", "Biología",
          "WEB 201", "SEC 101", "DAT 204", "UXD 101", "FOT 100", "GDEV 101"
        ], (val) {
          setState(() => selectedSubject = val);
        }),
        _buildMultiSelect("Disponibilidad", ["Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"], selectedAvailability, (val) {
          setState(() => selectedAvailability = val);
        }),
        _buildMultiSelect("Horario", ["Mañana", "Tarde", "Noche"], selectedTime, (val) {
          setState(() => selectedTime = val);
        }),
        _buildDropdown("Experiencia de tutoría", selectedExperience, [
          "< 1 Año","3h", "1-3 Años", "3-5 Años", "5+ Años"
        ], (val) {
          setState(() => selectedExperience = val);
        }),
        _buildDropdown("Títulos y certificaciones", selectedDegree, [
          "Licenciatura", "Maestría en Matemáticas Aplicadas", "Doctorado en Seguridad Informática", "Maestría en Ingeniería Web",
          "Maestría en Inteligencia Artificial", "Licenciatura en Diseño de Videojuegos", "Maestría en Desarrollo Interactivo","Licenciatura en Fotografía Profesional"
        ], (val) {
          setState(() => selectedDegree = val);
        }),
        _buildRatingSelector(),
        _buildPriceRangeSelector(),
      ],
    );
  }

  Widget _buildCourseFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDropdown("Categoría del curso", selectedCategory, [
          "Programación", "Matemáticas", "Ciencia de Datos", "Fotografía", "Desarrollo Web", "Videojuegos", "Ciberseguridad"
        ], (val) {
          setState(() => selectedCategory = val);
        }),
        _buildDropdown("Nivel de dificultad", selectedLevel, [
          "Principiante", "Intermedio", "Avanzado","Básico"
        ], (val) {
          setState(() => selectedLevel = val);
        }),
        _buildRatingSelector(),
        _buildPriceRangeSelector(),
        _buildMultiSelect("Duración", ["< 1 hr","3h", "1-3 hrs", "3-6 hrs", "6+ hrs"], selectedDuration, (val) {
          setState(() => selectedDuration = val);
        }),
        _buildDropdown("Publicado", selectedPublished, [
          "En el último mes", "En los últimos 6 meses", "En el último año","2025-01-10"
        ], (val) {
          setState(() => selectedPublished = val);
        }),
      ],
    );
  }

  Widget _buildMultiSelect(String title, List<String> options, List<String> selected, Function(List<String>) onSelected) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: options.map((option) {
            bool isSelected = selected.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (bool value) {
                final updated = List<String>.from(selected);
                if (value) {
                  updated.add(option);
                } else {
                  updated.remove(option);
                }
                onSelected(updated);
              },
              selectedColor: Colors.blue,
              labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDropdown(String label, String selectedValue, List<String> options, Function(String) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButton<String>(
            value: selectedValue,
            isExpanded: true,
            underline: const SizedBox(),
            onChanged: (String? newValue) {
              if (newValue != null) onChanged(newValue);
            },
            items: options.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRatingSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Clasificación", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < selectedRating ? Icons.star : Icons.star_border,
                color: Colors.orange,
              ),
              onPressed: () {
                setState(() {
                  selectedRating = index + 1;
                });
              },
            );
          }),
        ),
        Text("$selectedRating estrellas y más"),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildPriceRangeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Tarifa por hora", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SliderTheme(
          data: const SliderThemeData(showValueIndicator: ShowValueIndicator.always),
          child: RangeSlider(
            values: RangeValues(minRate, maxRate),
            min: 0,
            max: 100,
            divisions: 20,
            labels: RangeLabels("\$${minRate.toInt()}", "\$${maxRate.toInt()}"),
            onChanged: (RangeValues values) {
              setState(() {
                minRate = values.start;
                maxRate = values.end;
              });
            },
          ),
        ),
        Text("\$${minRate.toInt()} - \$${maxRate.toInt()}"),
      ],
    );
  }

 Widget _buildBottomButtons() {
  return Row(
    children: [
      Expanded(
        child: OutlinedButton(
          onPressed: () {},
          child: const Text("Restablecer filtro"),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: ElevatedButton(
          onPressed: () {
            // Verificamos cuántos filtros han sido seleccionados
            int selectedCount = 0;
            if (selectedSubject.isNotEmpty) selectedCount++;
            if (selectedAvailability.isNotEmpty) selectedCount++;
            if (selectedTime.isNotEmpty) selectedCount++;
            if (selectedExperience.isNotEmpty) selectedCount++;
            if (selectedDegree.isNotEmpty) selectedCount++;
            if (selectedCategory.isNotEmpty) selectedCount++;
            if (selectedLevel.isNotEmpty) selectedCount++;
            if (selectedDuration.isNotEmpty) selectedCount++;
            if (selectedPublished.isNotEmpty) selectedCount++;

            if (selectedCount >= 3) {
              // Si se han seleccionado al menos 3 filtros, proceder
              if (isTutorsSelected) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilteredTutorsScreen(
                      subject: selectedSubject,
                      availableDays: selectedAvailability,
                      minPrice: minRate,
                      maxPrice: maxRate,
                      rating: selectedRating.toDouble(),
                      experience: selectedExperience,
                      degree: selectedDegree,
                      time: selectedTime,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilteredCoursesScreen(
                      category: selectedCategory,
                      difficulty: selectedLevel,
                      minPrice: minRate,
                      maxPrice: maxRate,
                      rating: selectedRating.toDouble(),
                      published: selectedPublished,
                      duration: selectedDuration,
                    ),
                  ),
                );
              }
            } else {
              // Si no se han seleccionado al menos 3 filtros, mostrar un mensaje
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Selecciona al menos tres filtros'),
                  content: const Text('Debes seleccionar al menos tres filtros para aplicar la búsqueda.'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            }
          },
          child: const Text("Aplicar filtro"),
        ),
      ),
    ],
  );
}



}
