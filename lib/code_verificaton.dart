import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'enter_phone_number.dart';
import 'full_name.dart';

class CodeVerificaton extends StatefulWidget {
  final String countryCode;
  final String phoneNumber;

  const CodeVerificaton({
    Key? key,
    required this.countryCode,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<CodeVerificaton> createState() => _CodeVerificatonState();
}

class _CodeVerificatonState extends State<CodeVerificaton> {
  final TextEditingController digit1Controller = TextEditingController();
  final TextEditingController digit2Controller = TextEditingController();
  final TextEditingController digit3Controller = TextEditingController();
  final TextEditingController digit4Controller = TextEditingController();
  final TextEditingController digit5Controller = TextEditingController();
  final TextEditingController digit6Controller = TextEditingController();

  bool canResendCode = false;
  int _secondsRemaining = 60;
  Timer? _timer;

  String? _verificationId;
  String? debugMessage;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _verifyPhoneNumber();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    setState(() {
      canResendCode = false;
      _secondsRemaining = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          canResendCode = true;
          _timer?.cancel();
        }
      });
    });
  }

  void _verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "${widget.countryCode}${widget.phoneNumber}",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        _goToNextScreen();
      },
      verificationFailed: (FirebaseAuthException e) {
        print("❌ Verificación fallida: ${e.message}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("❌ Error al verificar número: ${e.message}"),
            backgroundColor: Colors.red,
          ),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        print("✅ Código enviado, ID: $verificationId");
        setState(() {
          _verificationId = verificationId;
          debugMessage = "📩 Código enviado (emulador): $verificationId";
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  Future<void> _verifyCodeAndContinue() async {
    final code = getEnteredCode();
    if (_verificationId == null || code.length != 6) return;

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: code,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      _goToNextScreen();
    } catch (e) {
      print("❌ Código incorrecto o error: $e");
      setState(() {
        debugMessage = "❌ Código incorrecto o expirado";
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("❌ Código incorrecto o expirado"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _goToNextScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FullName()),
    );
  }

  String getEnteredCode() {
    return digit1Controller.text +
        digit2Controller.text +
        digit3Controller.text +
        digit4Controller.text +
        digit5Controller.text +
        digit6Controller.text;
  }

  bool isCodeComplete() {
    return getEnteredCode().length == 6;
  }

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
          counterText: "",
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            FocusScope.of(context).nextFocus();
          }
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String fullNumber = "${widget.countryCode} ${widget.phoneNumber}";

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
                      MaterialPageRoute(builder: (_) => EnterPhoneNumber()),
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
                const Text(
                  "Verifica tu número",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Hemos enviado un código al número $fullNumber",
                  style: const TextStyle(
                    color: Color(0xFF475569),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDigitField(digit1Controller),
                    _buildDigitField(digit2Controller),
                    _buildDigitField(digit3Controller),
                    _buildDigitField(digit4Controller),
                    _buildDigitField(digit5Controller),
                    _buildDigitField(digit6Controller),
                  ],
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: isCodeComplete() ? _verifyCodeAndContinue : null,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: isCodeComplete()
                          ? const Color(0xFF0760FB)
                          : Colors.grey,
                      boxShadow: [
                        if (isCodeComplete())
                          const BoxShadow(
                            color: Color(0x26000000),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        "Continuar",
                        style: TextStyle(
                          color: isCodeComplete() ? Colors.white : Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                if (debugMessage != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      debugMessage!,
                      style: TextStyle(
                        color: debugMessage!.startsWith("❌")
                            ? Colors.red
                            : Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

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
                          text: canResendCode
                              ? "Vuelve a intentarlo"
                              : "Vuelve a intentarlo en $_secondsRemaining s",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = canResendCode
                                ? () {
                                    _verifyPhoneNumber();
                                    _startTimer();
                                  }
                                : null,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
