import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
// Importa la pantalla a la que regresa el botón Atrás
import 'EnterPhoneNumber.dart';
// Importa la pantalla a la que navega el botón Continuar
import 'FullName.dart';

class CodeVerificaton extends StatefulWidget {
  // Recibimos el código de país y el número desde EnterPhoneNumber
  final String countryCode;
  final String phoneNumber;

  const CodeVerificaton({
    Key? key,
    required this.countryCode,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<CodeVerificaton> createState() => _CodeVerificationState();
}

class _CodeVerificationState extends State<CodeVerificaton> {
  // Controladores para cada dígito del código
  final TextEditingController digit1Controller = TextEditingController();
  final TextEditingController digit2Controller = TextEditingController();
  final TextEditingController digit3Controller = TextEditingController();
  final TextEditingController digit4Controller = TextEditingController();
  // Si necesitas 6 dígitos, descomenta estos:
  // final TextEditingController digit5Controller = TextEditingController();
  // final TextEditingController digit6Controller = TextEditingController();

  // Función auxiliar para crear un TextField por dígito
  Widget _buildDigitField(TextEditingController controller) {
    return Container(
      width: 45,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        decoration: const InputDecoration(
          border: InputBorder.none,
          counterText: "", // Oculta el contador de caracteres
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            // Mover el foco al siguiente TextField
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Prepara el número completo para mostrarlo
    final String fullNumber = "${widget.countryCode} ${widget.phoneNumber}";

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Botón "Atrás" en azul que regresa a EnterPhoneNumber ---
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const EnterPhoneNumber()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back, color: Colors.blue),
                      const SizedBox(width: 8),
                      const Text(
                        "Atrás",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // --- Título ---
                const Text(
                  "Verifica tu número",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),

                // --- Descripción con el número al que se envió el código ---
                Text(
                  "Hemos enviado un código al número $fullNumber",
                  style: const TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 30),

                // --- Fila de TextFields para el código ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDigitField(digit1Controller),
                    _buildDigitField(digit2Controller),
                    _buildDigitField(digit3Controller),
                    _buildDigitField(digit4Controller),
                    // Descomenta si necesitas 6 dígitos:
                    // _buildDigitField(digit5Controller),
                    // _buildDigitField(digit6Controller),
                  ],
                ),
                const SizedBox(height: 30),

                // --- Botón "Continuar" que lleva a FullName ---
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FullName()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xFF0760FB),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x26000000),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
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

                // --- "Vuelve a enviarlo" en azul (acción comentada) ---
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "¿No recibiste el código? ",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: "Vuelve a enviarlo",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // Aquí iría la lógica para reenviar el código
                              // Por ejemplo, llamar a tu backend o servicio de SMS
                              // Navigator.push(...);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // --- Barra decorativa inferior ---
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
