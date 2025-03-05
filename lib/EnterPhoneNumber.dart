import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:tutorly/CodeVerificaton.dart';
import 'RoleSeparator.dart';

class EnterPhoneNumber extends StatefulWidget {
  const EnterPhoneNumber({super.key});

  @override
  EnterPhoneNumberState createState() => EnterPhoneNumberState();
}

class EnterPhoneNumberState extends State<EnterPhoneNumber> {
  // Controlador para el campo de teléfono
  final TextEditingController phoneController = TextEditingController();

  // Lista de países con códigos cortos y únicos
  final List<Map<String, String>> countryList = [
    {"name": "Estados Unidos", "code": "+1US"},
    {"name": "Canadá",         "code": "+1CA"},
    {"name": "Rep. Dominicana","code": "+1RD"},
    {"name": "México",         "code": "+52MX"},
    {"name": "España",         "code": "+34ES"},
  ];

  // Valor inicial (coincide con uno de los items)
  String selectedCountryCode = "+1US";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Permite que el contenido se desplace en dispositivos pequeños
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // BOTÓN "Atrás" en azul que regresa a RoleSeparator
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RoleSeparator()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_back, color: Colors.blue),
                      const SizedBox(width: 8),
                      const Text(
                        "Atrás",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // TÍTULO
                const Text(
                  "Introduce tu número",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // DESCRIPCIÓN
                const Text(
                  "Introduzca su número de teléfono para recibir el código de verificación.",
                  style: TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 30),

                // Etiqueta "Número de teléfono móvil"
                const Text(
                  "Número de teléfono móvil",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Fila con el Dropdown (código de país) y el campo para el número
                Row(
                  children: [
                    // Dropdown en un Flexible con maxWidth para evitar overflow
                    Flexible(
                      flex: 0,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 80),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFCBD5E1), width: 1),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedCountryCode,
                            icon: const Icon(Icons.arrow_drop_down, size: 16),
                            style: const TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 12,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedCountryCode = newValue!;
                              });
                            },
                            items: countryList.map<DropdownMenuItem<String>>((country) {
                              return DropdownMenuItem<String>(
                                value: country["code"],
                                child: Text(
                                  country["code"]!,
                                  style: const TextStyle(fontSize: 12),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),

                    // Campo de texto para el número
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Color(0xFFCBD5E1), width: 1),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.white,
                        ),
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "000-0000",
                            hintStyle: TextStyle(color: Color(0xFF64748B)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // BOTÓN "Continuar" que lleva a CodeVerificaton
                InkWell(
                  onTap: () {
                     Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => CodeVerificaton(
      countryCode: selectedCountryCode,
      phoneNumber: phoneController.text,
    ),
  ),
);

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF0760FB),
                      boxShadow: [
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

                // Enlace "¿Ya tienes una cuenta? Iniciar sesión" en azul
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "¿Ya tienes una cuenta? ",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Iniciar sesión",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Navegación a la pantalla de Login (código comentado)
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (_) => SomeLoginScreen()),
                              // );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Separador "O"
                Row(
                  children: [
                    Expanded(child: Container(color: Color(0xFFCBD5E1), height: 1)),
                    const SizedBox(width: 8),
                    const Text(
                      "O",
                      style: TextStyle(
                        color: Color(0xFF64748B),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Container(color: Color(0xFFCBD5E1), height: 1)),
                  ],
                ),
                const SizedBox(height: 20),

                // BOTÓN "Continuar con Google" (comentado)
                /*
                InkWell(
                  onTap: () {
                    // Implementar Google Sign-In
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFCBD5E1), width: 1),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Aquí podrías agregar el logo de Google si lo deseas
                        const SizedBox(width: 8),
                        const Text(
                          "Continuar con Google",
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                */
                const SizedBox(height: 30),

                // Barra decorativa inferior
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
