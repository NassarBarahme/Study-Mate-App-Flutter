import 'package:flutter/material.dart';

class MaterialsPage extends StatelessWidget {
  const MaterialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          MaterialCard(
            icon: Icons.code,
            color: Colors.deepOrange,
            title: "CS101",
            subtitle: "Introduction to Programming",
          ),
          MaterialCard(
            icon: Icons.storage,
            color: Colors.teal,
            title: "CS202",
            subtitle: "Data Structures",
          ),
          MaterialCard(
            icon: Icons.settings,
            color: Colors.purpleAccent,
            title: "CS303",
            subtitle: "Operating Systems",
          ),
          MaterialCard(
            icon: Icons.table_chart,
            color: Colors.indigo,
            title: "CS204",
            subtitle: "Database Systems",
          ),
          MaterialCard(
            icon: Icons.router,
            color: Colors.green,
            title: "CS305",
            subtitle: "Computer Networks",
          ),
        ],
      ),
    );
  }
}

/// 🔹 ويدجت خاصة بالكروت عشان الكود يكون أنظف
class MaterialCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;

  const MaterialCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15), // 🔹 خلفية فاتحة بنفس لون الأيقونة
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
      ),
    );
  }
}
