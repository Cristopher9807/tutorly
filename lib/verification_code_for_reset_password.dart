/*import 'package:flutter/material.dart';
import 'dart:async';
//import 'ResetPassword.dart';
import 'VerificationforResetPassword.dart';

class VerificationCodeforResetPassword extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  VerificationCodeforResetPassword({required this.verificationId, required this.phoneNumber});

  @override
  _VerificationCodeforResetPasswordState createState() => _VerificationCodeforResetPasswordState();
}

class _VerificationCodeforResetPasswordState extends State<VerificationCodeforResetPassword> {
  TextEditingController codeController = TextEditingController();
  int _secondsRemaining = 60;
  bool _canResend = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
          _timer?.cancel();
        });
      }
    });
  }

  void _resendCode() {
    if (_canResend) {
      setState(() {
        _secondsRemaining = 60;
        _canResend = false;
      });
      _startTimer();
      // Aquí puedes llamar a la función para reenviar el código.
      print('Código reenviado a ${widget.phoneNumber}');
    }
  }

  void _verifyCode() {
    // Aquí se validaría el código ingresado con el enviado
    if (codeController.text == "123456") { // Simulación de código correcto
      print("Código correcto, proceder a restablecer contraseña");
      // Navegar a ResetPassword.dart (descomentarlo cuando esté listo)
      // Navigator.push(context, MaterialPageRoute(builder: (_) => ResetPassword()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Código incorrecto, inténtalo de nuevo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => VerificationforResetPassword()));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Introduzca el código de verificación', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'Ingrese el código de 6 dígitos que le enviamos a su número de teléfono ',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                children: [
                  TextSpan(
                    text: widget.phoneNumber,
                    style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' para restablecer la contraseña.')
                ],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                hintText: '------',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _verifyCode,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Enviar', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Text('¿No has recibido el código?'),
                  GestureDetector(
                    onTap: _resendCode,
                    child: Text(
                      _canResend ? 'Vuelve a enviarlo' : 'Vuelve a enviarlo en $_secondsRemaining segundos',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
*/

import 'package:flutter/material.dart';
import 'dart:async';
import 'reset_password.dart';
//import 'VerificationforResetPassword.dart';

class VerificationCodeforResetPassword extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const VerificationCodeforResetPassword({super.key, required this.verificationId, required this.phoneNumber});

  @override
  // ignore: library_private_types_in_public_api
  _VerificationCodeforResetPasswordState createState() => _VerificationCodeforResetPasswordState();
}

class _VerificationCodeforResetPasswordState extends State<VerificationCodeforResetPassword> {
  TextEditingController codeController = TextEditingController();
  int _secondsRemaining = 60;
  bool _canResend = false;
  Timer? _timer;
  final String _testVerificationCode = "654321"; // Código de prueba

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
          _timer?.cancel();
        });
      }
    });
  }

  void _resendCode() {
    if (_canResend) {
      setState(() {
        _secondsRemaining = 60;
        _canResend = false;
      });
      _startTimer();
      // Aquí puedes agregar la función para reenviar el código real
      print('Código reenviado a ${widget.phoneNumber}');
    }
  }

  void _verifyCode() {
    if (codeController.text == _testVerificationCode) { 
      // Verifica si el código ingresado es correcto
      print("Código correcto, proceder a restablecer contraseña");
      
      // Navegar a la pantalla de restablecimiento de contraseña
      // Descomenta cuando ResetPassword esté listo
       Navigator.push(context, MaterialPageRoute(builder: (_) => ResetPassword()));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Código correcto, redirigiendo...')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Código incorrecto, inténtalo de nuevo.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verificación'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue),
          onPressed: () {
            Navigator.pop(context); // Regresa a la pantalla anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Introduce el código de verificación', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            RichText(
              text: TextSpan(
                text: 'Ingrese el código de 6 dígitos enviado a ',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                children: [
                  TextSpan(
                    text: widget.phoneNumber,
                    style: TextStyle(fontSize: 14, color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              decoration: InputDecoration(
                hintText: '------',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _verifyCode, // Verifica el código ingresado
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text('Enviar', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: Column(
                children: [
                  Text('¿No recibiste el código?'),
                  GestureDetector(
                    onTap: _resendCode,
                    child: Text(
                      _canResend ? 'Vuelve a enviarlo' : 'Vuelve a enviarlo en $_secondsRemaining segundos',
                      style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
