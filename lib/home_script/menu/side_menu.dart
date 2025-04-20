import 'package:flutter/material.dart';
import 'package:tutorly/role_separator.dart';
import 'perfil.dart';
import 'package:tutorly/congrats.dart';
import 'reviews.dart';
import 'package:tutorly/login.dart';
import 'package:tutorly/firestore_service.dart';
import 'package:tutorly/user_session.dart';

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
          // 🔹 Notificaciones
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.blueAccent),
                onPressed: () {
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
                    '5',
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

          // 🔹 Carrito
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Congrats()));
                }),
                _buildMenuItem(Icons.message, "Mensajes", () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Congrats()));
                }),
                _buildMenuItem(Icons.schedule, "Reserva de tutores", () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Congrats()));
                }),
                _buildMenuItem(Icons.play_circle_fill, "Mis cursos", () async {
                  //await createTutorAuthAccounts();
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Congrats()),);
                }),
                _buildMenuItem(Icons.star, "Valoración y reseñas", () {
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => const RatingsAndReviewsScreen()));
                }),
                _buildMenuItem(Icons.person, "Perfil", () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen()));
                }),
                const Divider(),
                _buildMenuItem(Icons.exit_to_app, "Salir", () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const RoleSeparator()));
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    final String name = UserSession.fullName ?? 'Nombre no disponible';
    final String email = UserSession.email ?? 'Correo no disponible';
    //final String profileImageUrl = UserSession.profileImageUrl ?? 'https://randomuser.me/api/portraits/men/44.jpg'; // Imagen predeterminada

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/219/219969.png'),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(email, style: const TextStyle(fontSize: 12, color: Colors.grey)),
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
