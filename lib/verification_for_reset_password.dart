/*import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:country_picker/country_picker.dart';
import 'package:tutorly/VerificationCodeforresetpassword.dart';
import 'login.dart';

class VerificationforResetPassword extends StatefulWidget {
  const VerificationforResetPassword({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _VerificationforResetPasswordState createState() => _VerificationforResetPasswordState();
}

class _VerificationforResetPasswordState extends State<VerificationforResetPassword> {
  Country selectedCountry = Country.worldWide;
  TextEditingController phoneController = TextEditingController();

  void _selectCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country;
        });
      },
    );
  }

  void _sendVerificationCode() async {
    String phoneNumber = '+${selectedCountry.phoneCode}${phoneController.text}';
    if (phoneController.text.isEmpty || phoneController.text.length < 7) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, introduce un número válido.')),
      );
      return;
    }

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        // Navegar a la pantalla de verificación del código
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VerificationCodeforResetPassword(verificationId: verificationId, phoneNumber: phoneNumber,),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restablecer contraseña'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Login()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Restablecer contraseña', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text(
              'Ingrese el número de teléfono asociado a su cuenta y le enviaremos instrucciones para restablecer su contraseña.',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 20),
            Text('Número de teléfono móvil', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: _selectCountry,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Text(
                          selectedCountry.flagEmoji,
                          style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(width: 8),
                        Text('+${selectedCountry.phoneCode}', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: '000-0000',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _sendVerificationCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Obtener instrucciones', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:country_picker/country_picker.dart';
import 'package:tutorly/verification_code_for_reset_password.dart';
//import 'login.dart';

class VerificationforResetPassword extends StatefulWidget {
  const VerificationforResetPassword({super.key});

  @override
  VerificationforResetPasswordState createState() => VerificationforResetPasswordState();
}

class VerificationforResetPasswordState extends State<VerificationforResetPassword> {
  Country selectedCountry = Country.worldWide;
  TextEditingController phoneController = TextEditingController();

  // Método para seleccionar el país
  void _selectCountry() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      onSelect: (Country country) {
        setState(() {
          selectedCountry = country;
        });
      },
    );
  }

  // Método para navegar a la pantalla de verificación (sin validaciones por ahora)
  void _navigateToVerificationScreen() {
    String phoneNumber = '+${selectedCountry.phoneCode}${phoneController.text.trim()}';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VerificationCodeforResetPassword(
          verificationId: "dummy_verification_id", // Se usa un ID ficticio por ahora
          phoneNumber: phoneNumber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restablecer contraseña'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context); // Corrige el error de navegación
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Restablecer contraseña', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              'Ingrese el número de teléfono asociado a su cuenta y le enviaremos instrucciones para restablecer su contraseña.',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),
            const Text('Número de teléfono móvil', style: TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Row(
              children: [
                GestureDetector(
                  onTap: _selectCountry,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Text(
                          selectedCountry.flagEmoji,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 8),
                        Text('+${selectedCountry.phoneCode}', style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: '000-0000',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _navigateToVerificationScreen, // Navega sin validaciones
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Obtener instrucciones', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
