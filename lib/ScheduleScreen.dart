/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
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
      home: ScheduleScreen(),
    );
  }
}

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
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
      builder: (_) => CalendarScreen(),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
        _formattedDate = DateFormat('EEEE, d MMMM', 'es_ES').format(date);
      });

      // Mostrar modal para seleccionar hora después de elegir fecha
      final result = await showModalBottomSheet<Map<String, TimeOfDay>>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (_) => TimePickerScreen(
          selectedDate: _selectedDate!,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programar tutoría'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dónde & cuándo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
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
                Text('Estudiaré en línea'),
              ],
            ),
            SizedBox(height: 16),
            Text('Dónde?'),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: '1901 Thornridge Cir. Shiloh',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 16),
            Text('Cuándo?'),
            GestureDetector(
              onTap: _openCalendarModal,
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Elige una fecha',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  controller: TextEditingController(text: _formattedDate),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------- Pantalla Calendario Modal ----------
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedMonth = DateTime.now();
  DateTime? _selectedDate;

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
      child: Column(
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

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = date;
                    });
                    Navigator.of(context).pop(date);
                  },
                  child: Container(
                    margin: EdgeInsets.all(4),
                    decoration: isSelected
                        ? BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(6))
                        : null,
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
      ),
    );
  }
}

// ---------- Pantalla Hora Modal ----------
class TimePickerScreen extends StatefulWidget {
  final DateTime selectedDate;

  const TimePickerScreen({super.key, required this.selectedDate});

  @override
  State<TimePickerScreen> createState() => _TimePickerScreenState();
}

class _TimePickerScreenState extends State<TimePickerScreen> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

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
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  Navigator.of(context).pop(); // Volver al calendario
                },
              )
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _selectTime(true),
                  child: Text(_startTime == null ? 'Hora de inicio' : _startTime!.format(context)),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _selectTime(false),
                  child: Text(_endTime == null ? 'Hora de fin' : _endTime!.format(context)),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_startTime != null && _endTime != null) {
                Navigator.of(context).pop({
                  'start': _startTime!,
                  'end': _endTime!,
                });
                // Aquí puedes añadir lógica para navegar a la siguiente pantalla:
                // Navigator.push(context, MaterialPageRoute(builder: (_) => SiguientePantalla()));
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text('Confirmar Fecha y Hora', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'DetallesPedido.dart';

void main() {
  runApp(MyApp());
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
      home: ScheduleScreen(),
    );
  }
}

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
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
      builder: (_) => CalendarScreen(),
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
        builder: (_) => TimePickerScreen(selectedDate: _selectedDate!),
      );

      if (result != null) {
        _startTime = result['start'];
        _endTime = result['end'];

        final startHour = _startTime!.hour + _startTime!.minute / 60;
        final endHour = _endTime!.hour + _endTime!.minute / 60;

        if (startHour >= endHour || startHour < 6 || endHour > 22) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Rango de horas inválido. Solo de 6:00 AM a 10:00 PM y hora de inicio debe ser antes que la de fin.')),
          );
        } else {
          final cantidadHoras = (endHour - startHour).ceil();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DetallesPedido(horasSeleccionadas: cantidadHoras),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Programar tutoría'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dónde & cuándo', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
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
                Text('Estudiaré en línea'),
              ],
            ),
            SizedBox(height: 16),
            Text('Dónde?'),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: '1901 Thornridge Cir. Shiloh',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 16),
            Text('Cuándo?'),
            GestureDetector(
              onTap: _openCalendarModal,
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Elige una fecha',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                  controller: TextEditingController(text: _formattedDate),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedMonth = DateTime.now();
  DateTime? _selectedDate;

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
      child: Column(
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

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = date;
                    });
                    Navigator.of(context).pop(date);
                  },
                  child: Container(
                    margin: EdgeInsets.all(4),
                    decoration: isSelected
                        ? BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(6))
                        : null,
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
      ),
    );
  }
}

class TimePickerScreen extends StatefulWidget {
  final DateTime selectedDate;

  const TimePickerScreen({super.key, required this.selectedDate});

  @override
  State<TimePickerScreen> createState() => _TimePickerScreenState();
}

class _TimePickerScreenState extends State<TimePickerScreen> {
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

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
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _selectTime(true),
                  child: Text(_startTime == null ? 'Hora de inicio' : _startTime!.format(context)),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _selectTime(false),
                  child: Text(_endTime == null ? 'Hora de fin' : _endTime!.format(context)),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_startTime != null && _endTime != null) {
                Navigator.of(context).pop({
                  'start': _startTime!,
                  'end': _endTime!,
                });
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            child: Text('Confirmar Fecha y Hora', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
