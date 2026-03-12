import 'package:flutter/material.dart';

class TestlerScreen extends StatelessWidget {
  const TestlerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Psikolojik Testler")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildTestTile("Stres Seviyesi Testi", "5 Soru ~ 5 Dakika"),
          const SizedBox(height: 10),
          _buildTestTile("Depresyon Tarama", "5 Soru ~ 5 Dakika"),
          const SizedBox(height: 10),
          _buildTestTile("Anksiyete Değerlendirmesi", "5 Soru ~ 5 Dakika"),
        ],
      ),
    );
  }

  Widget _buildTestTile(String title, String subtitle) {
    return ListTile(
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Color(0xFFF0F0F0)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
