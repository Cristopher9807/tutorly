// Al inicio de tu archivo
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutorly/user_session.dart';
import 'terms_conditions_screen.dart';
import 'privacy_policy_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                _buildProfileHeader(),
                const SizedBox(height: 10),
                _buildInfoSection(context),
                const SizedBox(height: 10),
                _buildOptionsSection(context, [
                  _buildOptionItem(context, Icons.person_outline, "Información personal", const Placeholder()),
                  _buildOptionItem(context, Icons.payment, "Pago", const Placeholder()),
                  _buildOptionItem(context, Icons.support_agent, "Soporte", const Placeholder()),
                  _buildOptionItem(context, Icons.lock_outline, "Login & Seguridad", const Placeholder()),
                ]),
                const SizedBox(height: 10),
                _buildOptionsSection(context, [
                  _buildOptionItem(
                    context, 
                    Icons.article_outlined, 
                    "Términos & Condiciones", 
                    const TermsConditionsScreen() // Aquí cambiamos el Placeholder por TermsConditionsScreen
                  ),
                  _buildOptionItem(context, Icons.privacy_tip_outlined, "Política de privacidad", const PrivacyPolicyScreen()),
                ]),
                const SizedBox(height: 10),
                _buildOptionsSection(context, [
                  _buildOptionItem(context, Icons.delete_outline, "Eliminar cuenta", const Placeholder(), color: Colors.red),
                  _buildOptionItem(context, Icons.exit_to_app, "Salir", null, color: Colors.red),
                ]),
              ],
            ),
          );
        },
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
                backgroundImage: AssetImage("assets/user.png"),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      UserSession.fullName ?? 'Nombre no disponible',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      UserSession.email ?? 'Correo no disponible',
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 120,
            height: 30,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text("Cambiar foto", style: TextStyle(fontSize: 11, color: Colors.blue)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    final id = UserSession.universityId ?? 'Identificación no disponible';
    final dept = UserSession.specialty ?? 'Especialidad no disponible';

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: _boxDecoration(),
      child: Column(
        children: [
          _buildInfoRow("Identificación\nuniversitaria", id),
          const Divider(),
          _buildInfoRow("Departamento", dept),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              title,
              style: const TextStyle(color: Color.fromARGB(221, 66, 66, 66), fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
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
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
