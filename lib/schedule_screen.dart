 import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutorly/user_session.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tutorly/detalles_pedido.dart';


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
        courseId: '9ocu4dVB7ea8W65vmrem',
        tutorId: 'andres.rojas@gmail.com',
        courseName: 'GDEV 101',
        price: 30.0,
        //availableDays: ['Lunes']
      ),
    );
  }
}

class ScheduleScreen extends StatefulWidget {
  final String courseId;
  final String tutorId;
  final String courseName;
  final double price;

  //final List<String> availableDays;
  final VoidCallback? onScheduled; // Nuevo parámetro opcional

  const ScheduleScreen({
    Key? key,
    required this.courseId,
    required this.tutorId,
    required this.courseName,
    required this.price,

    //required this.availableDays,
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
  String? _courseDifficulty;
  List<String> _availableDays = [];
  bool _isDateAvailable = false; // Variable para controlar si la fecha es válida

  @override
  void initState() {
    super.initState();
    print('📘 Curso: ${widget.courseName}');
    print('👨‍🏫 Tutor ID: ${widget.tutorId}');
    print('📚 Course ID: ${widget.courseId}');
    _fetchCourseDifficulty();
  }

  Future<void> _fetchCourseDifficulty() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('tutors')
          .doc(widget.tutorId)
          .collection('courses')
          .doc(widget.courseId)
          .get();

      if (doc.exists) {
        final data = doc.data();
        final difficulty = data?['difficulty'];
        final days = data?['availableDays'];

        setState(() {
          _courseDifficulty = difficulty is String ? difficulty : 'Desconocida';
          
          // Convertir los días disponibles a minúsculas
          _availableDays = (days is List)
              ? List<String>.from(days.map((day) => (day as String).toLowerCase()))
              : [];
        });

        print('📚 Dificultad del curso: $_courseDifficulty');
        print('📆 Días disponibles: $_availableDays');
      } else {
        print('⚠️ Curso no encontrado');
      }
    } catch (e) {
      print('❌ Error al obtener dificultad del curso: $e');
    }
  }

  Future<void> _openCalendarModal() async {
    final date = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => CalendarScreen(courseId: widget.courseId),
    );

    if (date != null) {
      final dayName = DateFormat('EEEE', 'es_ES').format(date).toLowerCase();

      final isAvailable = _availableDays.contains(dayName);

      setState(() {
        _selectedDate = date;
        _formattedDate = DateFormat('EEEE, d MMMM', 'es_ES').format(date);
        _isDateAvailable = isAvailable;
        _startTime = null;
        _endTime = null;
      });

      if (!isAvailable) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('El curso no está disponible ese día. Días disponibles: $_availableDays')),
        );
        return;
      }

      // ✅ Elegir hora de inicio
      final pickedStartTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedStartTime != null) {
        final defaultEndTime = TimeOfDay(
          hour: (pickedStartTime.hour + 1) % 24,
          minute: pickedStartTime.minute,
        );

        // ✅ Elegir hora de fin
        final pickedEndTime = await showTimePicker(
          context: context,
          initialTime: defaultEndTime,
        );

        if (pickedEndTime != null) {
          setState(() {
            _startTime = pickedStartTime;
            _endTime = pickedEndTime;
          });
        }
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

    // Verificar si ya existe una cita a esa hora
    final querySnapshot = await FirebaseFirestore.instance
        .collection('appointments')
        .where('startTime', isEqualTo: Timestamp.fromDate(startDateTime.toLocal()))
        .where('tutorId', isEqualTo: widget.tutorId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Si ya existe una cita, mostrar un mensaje
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ya existe una cita a esa hora, por favor elige otra hora.')),
      );
      return;  // No continuar guardando la cita
    }

    // Si no existe una cita a esa hora, guardar la nueva cita
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
      //Navigator.of(context).pop();

      
      final durationInMinutes = endDateTime.difference(startDateTime).inMinutes;
      final double hours = durationInMinutes / 60;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => DetallesPedido(
            horasSeleccionadas: hours,
            // pricePerHour: widget.price, // Puedes pasar este si lo necesitas también
          ),
        ),
      );


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
              onPressed: _isDateAvailable ? _saveAppointment : null, // Botón deshabilitado si la fecha no es válida
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
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now(); // Día seleccionado por defecto
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Selecciona una fecha',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TableCalendar(
            firstDay: DateTime.utc(2023, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              // Solo el seleccionado aparece resaltado
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              // Actualiza el mes visible
              _focusedDay = focusedDay;
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              todayTextStyle: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.deepPurple,
                shape: BoxShape.circle,
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronIcon: Icon(Icons.chevron_left),
              rightChevronIcon: Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _selectedDay != null
                ? () => Navigator.pop(context, _selectedDay)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text('Confirmar', style: TextStyle(color: Colors.white)),
          ),
        ],
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