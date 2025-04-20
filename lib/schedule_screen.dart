 import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutorly/user_session.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Programar Tutoría',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScheduleScreen(
        courseId: '123',
        tutorId: '456',
        courseName: 'Matemáticas',
      ),
    );
  }
}

class ScheduleScreen extends StatefulWidget {
  final String courseId;
  final String tutorId;
  final String courseName;
  final VoidCallback? onScheduled; // Nuevo parámetro opcional

  const ScheduleScreen({
    Key? key,
    required this.courseId,
    required this.tutorId,
    required this.courseName,
    this.onScheduled,
  }) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}


class _ScheduleScreenState extends State<ScheduleScreen> {
  bool _isOnline = false;
  TextEditingController _locationController = TextEditingController();
  DateTime? _selectedDate;
  String? _formattedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  Future<void> _openCalendarModal() async {
    final date = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => CalendarScreen(courseId: widget.courseId),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
        _formattedDate = DateFormat('EEEE, d MMMM', 'es_ES').format(date);
      });

      final result = await showModalBottomSheet<Map<String, TimeOfDay>>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (_) => TimePickerScreen(
          selectedDate: _selectedDate!,
          courseId: widget.courseId,
        ),
      );

      if (result != null) {
        setState(() {
          _startTime = result['start'];
          _endTime = result['end'];
        });
      }
    }
  }

  Future<void> _saveAppointment() async {
    if (_selectedDate == null || _startTime == null || _endTime == null) {
      print('Fecha o hora no seleccionada');
      return;
    }

    final startDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _startTime!.hour,
      _startTime!.minute,
    );

    final endDateTime = DateTime(
      _selectedDate!.year,
      _selectedDate!.month,
      _selectedDate!.day,
      _endTime!.hour,
      _endTime!.minute,
    );

    // Verificar los valores
    print('Fecha seleccionada: $_selectedDate');
    print('Hora de inicio: $startDateTime');
    print('Hora de fin: $endDateTime');
    print('Email: ${UserSession.email}');
    print('Full Name: ${UserSession.fullName}');

    final appointment = {
      'courseId': widget.courseId,
      'courseName': widget.courseName,
      'tutorId': widget.tutorId,
      'studentEmail': UserSession.email,
      'studentName': UserSession.fullName,
      'isOnline': _isOnline,
      'location': _isOnline ? null : _locationController.text.trim(),
      'date': Timestamp.fromDate(_selectedDate!),
      'startTime': Timestamp.fromDate(startDateTime.toLocal()),
      'endTime': Timestamp.fromDate(endDateTime.toLocal()),
      'status': 'scheduled',
    };

    try {
      await FirebaseFirestore.instance.collection('appointments').add(appointment).then((docRef) {
        print("✅ ¡Cita registrada correctamente! ID: ${docRef.id}");
      });


      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tutoría programada con éxito')),
        
      );
      // Llama al callback si se definió
      widget.onScheduled?.call(); 
      Navigator.of(context).pop();
    } catch (e) {
      print('Error al guardar la tutoría: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al guardar la tutoría')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Programar tutoría'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.courseName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Dónde & cuándo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              children: [
                Checkbox(
                  value: _isOnline,
                  onChanged: (val) {
                    setState(() {
                      _isOnline = val!;
                    });
                  },
                ),
                const Text('Estudiaré en línea'),
              ],
            ),
            const SizedBox(height: 16),
            if (!_isOnline) ...[
              const Text('Dónde?'),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  hintText: '1901 Thornridge Cir. Shiloh',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
              const SizedBox(height: 16),
            ],
            const Text('Cuándo?'),
            GestureDetector(
              onTap: _openCalendarModal,
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Elige una fecha',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  controller: TextEditingController(text: _formattedDate),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (_startTime != null && _endTime != null)
              Text(
                'De ${_startTime!.format(context)} a ${_endTime!.format(context)}',
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveAppointment,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text('Confirmar tutoría', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Pantalla Calendario Modal ----------

class CalendarScreen extends StatefulWidget {
  final String courseId;

  const CalendarScreen({Key? key, required this.courseId}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedMonth = DateTime.now();
  DateTime? _selectedDate;

  Future<List<DateTime>> _getAvailableDates() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('courses')
          .doc(widget.courseId)
          .get();

      if (!doc.exists) return [];

      final List<String> availableWeekdays = List<String>.from(doc['availableDays']);

      final dayMap = {
        'Lunes': DateTime.monday,
        'Martes': DateTime.tuesday,
        'Miércoles': DateTime.wednesday,
        'Jueves': DateTime.thursday,
        'Viernes': DateTime.friday,
        'Sábado': DateTime.saturday,
        'Domingo': DateTime.sunday,
      };

      final availableDayNumbers = availableWeekdays
          .where((d) => dayMap.containsKey(d))
          .map((d) => dayMap[d]!)
          .toList();

      final daysInMonth = DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
      final dates = <DateTime>[];

      for (int i = 1; i <= daysInMonth; i++) {
        final date = DateTime(_focusedMonth.year, _focusedMonth.month, i);
        if (availableDayNumbers.contains(date.weekday)) {
          dates.add(date);
        }
      }

      return dates;
    } catch (e) {
      print("Error al obtener fechas disponibles: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateUtils.getDaysInMonth(_focusedMonth.year, _focusedMonth.month);
    final firstWeekday = DateTime(_focusedMonth.year, _focusedMonth.month, 1).weekday;

    return Container(
      margin: EdgeInsets.only(top: 100),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: FutureBuilder<List<DateTime>>(
        future: _getAvailableDates(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final availableDates = snapshot.data ?? [];

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                      setState(() {
                        _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1);
                      });
                    },
                  ),
                  Text(
                    DateFormat('MMMM', 'es_ES').format(_focusedMonth).toUpperCase(),
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () {
                      setState(() {
                        _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1);
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: ['LUN', 'MAR', 'MIE', 'JUE', 'VIE', 'SAB', 'DOM']
                    .map((d) => Expanded(child: Center(child: Text(d))))
                    .toList(),
              ),
              SizedBox(height: 8),
              Flexible(
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: daysInMonth + firstWeekday - 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisExtent: 40,
                  ),
                  itemBuilder: (context, index) {
                    if (index < firstWeekday - 1) return SizedBox();
                    final day = index - firstWeekday + 2;
                    final date = DateTime(_focusedMonth.year, _focusedMonth.month, day);
                    final isSelected = _selectedDate != null &&
                        _selectedDate!.year == date.year &&
                        _selectedDate!.month == date.month &&
                        _selectedDate!.day == date.day;
                    final isAvailable = availableDates.contains(date);

                    return GestureDetector(
                      onTap: isAvailable
                          ? () {
                              setState(() {
                                _selectedDate = date;
                              });
                              Navigator.of(context).pop(date);
                            }
                          : null,
                      child: Container(
                        margin: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: isAvailable ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            '$day',
                            style: TextStyle(color: isSelected ? Colors.white : Colors.black),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ---------- Pantalla Hora Modal ----------

class TimePickerScreen extends StatefulWidget {
  final DateTime selectedDate;
  final String courseId;

  const TimePickerScreen({super.key, required this.selectedDate, required this.courseId});

  @override
  _TimePickerScreenState createState() => _TimePickerScreenState();
}

class _TimePickerScreenState extends State<TimePickerScreen> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  Future<bool> _isTimeAvailable(TimeOfDay? startTime, TimeOfDay? endTime) async {
    // Verificar si los horarios son válidos (no nulos)
    if (startTime == null || endTime == null) {
      return false; // Si algún horario es nulo, consideramos que no está disponible.
    }

    // Convertir TimeOfDay a DateTime para poder compararlos con los tiempos almacenados en Firestore
    DateTime startDateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      startTime.hour,
      startTime.minute,
    );
    DateTime endDateTime = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      endTime.hour,
      endTime.minute,
    );

    // Consultar Firestore para obtener citas existentes y verificar si hay algún solapamiento
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('startTime', isLessThanOrEqualTo: endDateTime)
        .where('endTime', isGreaterThanOrEqualTo: startDateTime)
        .get();

    // Si la consulta devuelve resultados, significa que hay una cita en ese intervalo de tiempo
    if (querySnapshot.docs.isNotEmpty) {
      return false; // El horario no está disponible
    }

    // Si no hay citas en ese rango, el horario está disponible
    return true;
  }

  Future<void> _selectTime(bool isStart) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('EEEE, d MMMM', 'es_ES').format(widget.selectedDate);

    return Container(
      margin: EdgeInsets.only(top: 100),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    hintText: formattedDate,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _selectTime(true),
                  child: Text(
                    _startTime != null
                        ? 'Inicio: ${_startTime!.format(context)}'
                        : 'Seleccionar hora de inicio',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _selectTime(false),
                  child: Text(
                    _endTime != null
                        ? 'Fin: ${_endTime!.format(context)}'
                        : 'Seleccionar hora de fin',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_startTime != null && _endTime != null) {
                // Ahora llamamos a _isTimeAvailable con los valores no nulos
                _isTimeAvailable(_startTime, _endTime).then((isAvailable) {
                  if (isAvailable) {
                    // Si los horarios están disponibles, se confirma la tutoría.
                    Navigator.of(context).pop(<String, TimeOfDay>{'start': _startTime!, 'end': _endTime!});
                  } else {
                    // Si no están disponibles, mostramos un mensaje de error.
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('El horario no está disponible')),
                    );
                  }
                });
              }
            },
            child: Text('Confirmar horario'),
          ),
        ],
      ),
    );
  }
}

