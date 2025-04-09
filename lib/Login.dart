import 'package:flutter/material.dart';
import 'enter_phone_number.dart';
import 'verification_for_reset_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_session.dart';

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

Future<void> _login() async {
  try {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    debugPrint("📩 Email: $email");
    debugPrint("🔒 Password: $password");

    if (email.isEmpty || password.isEmpty) {
      debugPrint("⚠️ Campos vacíos");
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, llena todos los campos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    debugPrint("🔐 Autenticando...");

    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    debugPrint("✅ Usuario autenticado");

    QuerySnapshot userQuery = await _firestore
        .collection('users')
        .where('email', isEqualTo: email.toLowerCase())
        .limit(1)
        .get();

    debugPrint("📦 Consulta completada");

    if (userQuery.docs.isNotEmpty) {
      final userData = userQuery.docs.first.data() as Map<String, dynamic>;

      debugPrint("📄 Datos del usuario Firestore: $userData");

      final userRoleInDB = userData['user']?.toString().toLowerCase();
      final selectedRole = UserSession.selectedRole?.toLowerCase();

      debugPrint("🧪 Comparando rol Firestore: $userRoleInDB con seleccionado: $selectedRole");

      if (userRoleInDB == selectedRole) {
        debugPrint("✅ Rol coincide");
        Navigator.pushNamed(context, '/Congrats');
      } else {
        debugPrint("❌ Rol no coincide");

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('El rol seleccionado no coincide con tu cuenta.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    } else {
      debugPrint("❌ No se encontró usuario con ese email en Firestore.");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Usuario no encontrado en la base de datos.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  } catch (e) {
    debugPrint("❌ Error en login: $e");

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