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
      home: const NotificationsScreen(),
    );
  }
}

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool showUnread = true;

  final List<NotificationItem> notifications = [
    NotificationItem(
      icon: Icons.person,
      title: "Robert Fox viene al lugar seleccionado para la sesión.",
      time: "6h atrás",
      unread: true,
    ),
    NotificationItem(
      icon: Icons.event_available,
      title: "Tu sesión en vivo con Robert Fox comienza en 30 minutos. ¡Prepárate!",
      time: "Lunes 12:18am",
      unread: false,
    ),
    NotificationItem(
      icon: Icons.cancel,
      title: "Tu sesión con Robert Fox del 01 Jul, 12:00-13:00 ha sido cancelada",
      time: "1s atrás",
      unread: true,
    ),
    NotificationItem(
      icon: Icons.check_circle,
      title: "Has adquirido con éxito el curso Estrategias de resolución de problemas. Comienza a aprender ahora",
      time: "19d atrás",
      unread: false,
    ),
    NotificationItem(
      icon: Icons.local_offer,
      title: "Oferta especial: ¡Obtén un 20% de descuento en estrategias para la resolución de problemas! ¡Solo por tiempo limitado!",
      time: "1m atrás",
      unread: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notificaciones", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var notification in notifications) {
                  notification.unread = false;
                }
              });
            },
            child: const Text("Marcar todo como leído", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildTabBar(),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              children: notifications
                  .where((n) => showUnread ? n.unread : true)
                  .map((n) => _buildNotificationTile(n))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          _buildTabButton("No leído", showUnread),
          const SizedBox(width: 10),
          _buildTabButton("Todo", !showUnread),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, bool isActive) {
    return GestureDetector(
      onTap: () => setState(() => showUnread = text == "No leído"),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black54,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationTile(NotificationItem notification) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: notification.unread ? Colors.white : Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: notification.unread
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(notification.icon, color: _getIconColor(notification.icon)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  notification.time,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getIconColor(IconData icon) {
    switch (icon) {
      case Icons.person:
        return Colors.blue;
      case Icons.event_available:
        return Colors.grey;
      case Icons.cancel:
        return Colors.red;
      case Icons.check_circle:
        return Colors.green;
      case Icons.local_offer:
        return Colors.purple;
      default:
        return Colors.black;
    }
  }
}

class NotificationItem {
  final IconData icon;
  final String title;
  final String time;
  bool unread;

  NotificationItem({
    required this.icon,
    required this.title,
    required this.time,
    required this.unread,
  });
}
