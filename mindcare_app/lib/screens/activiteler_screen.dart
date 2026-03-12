import 'package:flutter/material.dart';

class AktivitelerScreen extends StatelessWidget {
  const AktivitelerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aktiviteler")),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        children: [
          _buildActivityCard("Meditasyon", Icons.self_improvement, Colors.teal),
          _buildActivityCard("Egzersiz", Icons.directions_run, Colors.orange),
          _buildActivityCard("Nefes", Icons.air, Colors.blue),
          _buildActivityCard("Yaratıcılık", Icons.brush, Colors.purple),
        ],
      ),
    );
  }

  Widget _buildActivityCard(String title, IconData icon, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 40),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
