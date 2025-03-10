/*import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'CodeVerificaton.dart';
import 'Email.dart';

class FullName extends StatefulWidget {
  const FullName({super.key});
  
  @override
  FullNameState createState() => FullNameState();
}

class FullNameState extends State<FullName> {
  String textField1 = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Permite el scroll en dispositivos con pantallas pequeñas
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Botón "Atrás" en azul que navega a CodeVerificaton.dart
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CodeVerificaton(countryCode: '', phoneNumber: '',),
                      ),
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
                
                // Título de la pantalla
                const Text(
                  "¿Cómo te llamas?",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Etiqueta "Nombre Completo"
                const Text(
                  "Nombre Completo",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                
                // Campo de texto para el nombre
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x12344054),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
                  child: TextField(
                    style: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
                    onChanged: (value) {
                      setState(() {
                        textField1 = value;
                      });
                    },
                    maxLength: 20,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    inputFormatters: [
                      // Permite solo letras (mayúsculas y minúsculas) y espacios
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    ],
                    decoration: const InputDecoration(
                      hintText: "Pedro Castillo",
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      border: InputBorder.none,
                      counterText: "",
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                
                // Botón "Continuar" que lleva a Email.dart y se activa solo si hay texto
                InkWell(
                  onTap: textField1.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const Email(),
                            ),
                          );
                        },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: textField1.isEmpty ? Colors.grey : const Color(0xFF0760FB),
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
                const SizedBox(height: 20),
                
                // Enlace "Vuelve a enviarlo" en azul (acción comentada para implementar en el futuro)
               /* Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Vuelve a enviarlo",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Aquí iría la lógica para reenviar el código
                          // Ejemplo:
                          // Navigator.push(context, MaterialPageRoute(builder: (_) => ReenviarCodigoScreen()));
                        },
                    ),
                  ),
                ),*/
                
                const SizedBox(height: 30),
                
                
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

*/





import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'CodeVerificaton.dart';
import 'Email.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FullName extends StatefulWidget {
  final String phoneNumber; // Agrega el número de teléfono

  const FullName({Key? key, required this.phoneNumber}) : super(key: key); // Modifica el constructor
  
  @override
  FullNameState createState() => FullNameState();
}

// Luego, usa phoneNumber en la lógica de guardado


class FullNameState extends State<FullName> {
  String textField1 = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CodeVerification(countryCode: '', phoneNumber: ''),
                      ),
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
                
                const Text(
                  "¿Cómo te llamas?",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                
                const Text(
                  "Nombre Completo",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x12344054),
                        blurRadius: 2,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 13),
                  child: TextField(
                    style: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
                    onChanged: (value) {
                      setState(() {
                        textField1 = value;
                      });
                    },
                    maxLength: 20,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]')),
                    ],
                    decoration: const InputDecoration(
                      hintText: "Pedro Castillo",
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                      border: InputBorder.none,
                      counterText: "",
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                
                InkWell(
                  onTap: textField1.isEmpty
                  ? null
                  : () async {
                      await FirebaseFirestore.instance.collection('users').doc(widget.phoneNumber).set({
                        'fullName': textField1,
                      }, SetOptions(merge: true));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Email(phoneNumber: widget.phoneNumber)), // Pasa el número de teléfono
                      );
                    },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: textField1.isEmpty ? Colors.grey : const Color(0xFF0760FB),
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
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
