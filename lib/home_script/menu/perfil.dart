import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 10),
            _buildInfoSection(),
            const SizedBox(height: 10),
            _buildOptionsSection(context, [
              _buildOptionItem(context, Icons.person_outline, "Información personal", const PersonalInfoScreen()),
              _buildOptionItem(context, Icons.payment, "Pago", const PaymentScreen()),
              _buildOptionItem(context, Icons.support_agent, "Soporte", const SupportScreen()),
              _buildOptionItem(context, Icons.lock_outline, "Login & Seguridad", const SecurityScreen()),
            ]),
            const SizedBox(height: 10),
            _buildOptionsSection(context, [
              _buildOptionItem(context, Icons.article_outlined, "Términos & Condiciones", const TermsScreen()),
              _buildOptionItem(context, Icons.privacy_tip_outlined, "Política de privacidad", const PrivacyScreen()),
            ]),
            const SizedBox(height: 10),
            _buildOptionsSection(context, [
              _buildOptionItem(context, Icons.delete_outline, "Eliminar cuenta", const DeleteAccountScreen(), color: Colors.red),
              _buildOptionItem(context, Icons.exit_to_app, "Salir", null, color: Colors.red),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: _boxDecoration(),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 35,
                backgroundImage: NetworkImage("https://randomuser.me/api/portraits/women/44.jpg"),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("María García", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    const Text("880 1777395216", style: TextStyle(color: Colors.grey)),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Row(
                          children: List.generate(5, (index) => const Icon(Icons.star, color: Colors.orange, size: 16)),
                        ),
                        const SizedBox(width: 5),
                        const Text("4.5", style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 120, // Ancho del botón
                height: 30, // Altura del botón
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text("Cambiar foto",style: TextStyle(fontSize: 11, color: Colors.blue)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: _boxDecoration(),
      child: Column(
        children: [
          _buildInfoRow("Identificación universitaria", "189204 8923"),
          const Divider(),
          _buildInfoRow("Departamento", "Ingeniería en Ciencias\nInformáticas"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.right),
        ],
      ),
    );
  }

  Widget _buildOptionsSection(BuildContext context, List<Widget> options) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: _boxDecoration(),
      child: Column(children: options),
    );
  }

  Widget _buildOptionItem(BuildContext context, IconData icon, String title, Widget? screen, {Color color = Colors.black}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontSize: 16)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        if (screen != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        }
      },
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
}

// Pantallas de ejemplo
class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderScreen(context, "Información Personal");
  }
}

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderScreen(context, "Pago");
  }
}

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderScreen(context, "Soporte");
  }
}

class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderScreen(context, "Login & Seguridad");
  }
}

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderScreen(context, "Términos & Condiciones");
  }
}

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderScreen(context, "Política de Privacidad");
  }
}

class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildPlaceholderScreen(context, "Eliminar Cuenta");
  }
}

Widget _buildPlaceholderScreen(BuildContext context, String title) {
  return Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Text("Pantalla de $title")),
  );
}
