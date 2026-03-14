import 'package:flutter/material.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7EE),
      appBar: AppBar(
        title: const Text('Aktiviteler',
            style: TextStyle(color: Color(0xFF1B4332))),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF72B01D)),
      ),
      body: ListView(
        // SingleChildScrollView yerine ListView daha performanslıdır
        padding: const EdgeInsets.all(20),
        children: [
          _buildCategoryCard(
              'Meditasyon',
              'Zihnini dinlendir',
              Icons.self_improvement,
              const Color(0xFF72B01D),
              ['5 Dakika Nefes', '10 Dakika Farkındalık']),
          const SizedBox(height: 16),
          _buildCategoryCard('Nefes Egzersizleri', 'Derin nefes al', Icons.air,
              const Color(0xFF72B01D), ['4-7-8 Nefesi', 'Kutu Nefesi']),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String title, String subtitle, IconData icon,
      Color color, List<String> items) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // HATA DÜZELTME: withValues kullanıldı
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ],
          ),
          ...items.map((item) => ListTile(
                title: Text(item),
                leading: const Icon(Icons.play_circle_fill,
                    color: Color(0xFF72B01D)),
                onTap: () {},
              )),
        ],
      ),
    );
  }
}
