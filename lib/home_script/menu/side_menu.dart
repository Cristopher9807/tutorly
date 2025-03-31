import 'package:flutter/material.dart';
import 'perfil.dart';
import 'package:tutorly/congrats.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tutorly", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        actions: [
          // 🔹 Ícono de Notificaciones con Contador
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.blueAccent),
                onPressed: () {
                  // Navega a la pantalla de notificaciones
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  child: const Text(
                    '5', // 📌 Número de notificaciones
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),

          // 🔹 Ícono de Carrito de Compras
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.blueAccent),
            onPressed: () {
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
            },
          ),
        ],
      ),

      // 🔹 Drawer (Menú lateral)
      drawer: const SideMenu(),

      body: const Center(
        child: Text("Pantalla principal"),
      ),
    );
  }
}

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserHeader(),
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(Icons.home, "Inicio", () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Congrats()));
                }),
                _buildMenuItem(Icons.message, "Mensajes", () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Congrats()));
                }),
                _buildMenuItem(Icons.schedule, "Reserva de tutores", () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Congrats()));
                }),
                _buildMenuItem(Icons.play_circle_fill, "Mis cursos", () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Congrats()));
                }),
                _buildMenuItem(Icons.star, "Valoración y reseñas", () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Congrats()));
                }),
                _buildMenuItem(Icons.person, "Perfil", () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
                }),
                const Divider(),
                _buildMenuItem(Icons.exit_to_app, "Salir", () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage("https://randomuser.me/api/portraits/women/44.jpg"),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("María García", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text("maría.garcia@email.com", style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: const TextStyle(fontSize: 14)),
      onTap: onTap,
    );
  }
}
