import 'package:flutter/material.dart';
import 'EnterPhoneNumber.dart';
import 'VerificationforResetPassword.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Login extends StatefulWidget {
  const Login({super.key});  // ✅ CORRECTO
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool obscurePassword = true;

 /* Future<void> _login() async {
    try {
      final String email = emailController.text.trim();
      final String password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        if (!mounted) return; // Verifica si el widget sigue montado
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Por favor, llena todos los campos'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      debugPrint("🟢 Intentando iniciar sesión con: $email");

      // 🔹 Intentar iniciar sesión con Firebase Authentication
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint("✅ Usuario autenticado: ${userCredential.user?.uid}");

      // 🔍 Buscar en Firestore por el email
      QuerySnapshot userQuery = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (!mounted) return; // ⚠️ Verifica antes de usar `context`

      if (userQuery.docs.isNotEmpty) {
        debugPrint("✅ Usuario encontrado en Firestore");
        Navigator.pushNamed(context, '/Congrats');
      } else {
        debugPrint("❌ Usuario NO encontrado en Firestore");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Usuario no encontrado en la base de datos.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint("❌ Error al iniciar sesión: $e");

      if (!mounted) return; // ⚠️ Verifica antes de usar `context`

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al iniciar sesión: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
*/

Future<void> _login() async {
  try {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, llena todos los campos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    debugPrint("🟢 Intentando iniciar sesión con: $email");

    // 🔹 Intentar iniciar sesión con Firebase Authentication
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    debugPrint("✅ Usuario autenticado: ${userCredential.user?.uid}");

    // 🔍 Verificar en Firestore
    QuerySnapshot userQuery = await _firestore
        .collection('users')
        .where('email', isEqualTo: email.toLowerCase())
        .limit(1)
        .get();

    if (!mounted) return;

    if (userQuery.docs.isNotEmpty) {
      debugPrint("✅ Usuario encontrado en Firestore: ${userQuery.docs.first.data()}"); // Primero imprime el mensaje
      await Future.delayed(Duration(milliseconds: 200)); // Pequeña pausa para asegurarse de que se imprima
      Navigator.pushNamed(context, '/Congrats'); // Luego navega a la otra pantalla
    } else {
      debugPrint("❌ Usuario NO encontrado en Firestore. Verifica si el email está bien escrito.");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuario no encontrado en la base de datos.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
  debugPrint("❌ Error al iniciar sesión: $e");

  if (!mounted) return;

  String errorMessage = "Error al iniciar sesión.";
  if (e is FirebaseAuthException) {
    if (e.code == "invalid-credential") {
      errorMessage = "Correo o contraseña incorrectos.";
    }
  }

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(errorMessage),
      backgroundColor: Colors.red,
    ),
  );
}

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo.png', height: 250),
                const SizedBox(height: 20),
                const Text(
                  'Iniciar Sesión',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 153, 0)),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Correo electrónico',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseñas',
                    prefixIcon: const Icon(Icons.lock),
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(obscurePassword ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                  obscureText: obscurePassword,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              rememberMe = value ?? false;
                            });
                          },
                        ),
                        const Text('Acuérdate de mí'),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => VerificationforResetPassword()),
                        );
                      },
                      child: const Text('Olvidé mi contraseña'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Continuar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("¿No tienes cuenta?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EnterPhoneNumber()),
                        );
                      },
                      child: const Text('Regístrate aquí'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}