import 'package:flutter/material.dart';

class TestsScreen extends StatelessWidget {
  const TestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7EE),
      appBar: AppBar(
        title: const Text(
          'Testler',
          style: TextStyle(color: Color(0xFF1B4332)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF72B01D)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Ruh Halini Değerlendir',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B4332),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Kendini daha iyi tanımak için testleri çöz',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildTestCard(
              context, // ← context'i parametre olarak ekledik
              '😊',
              'Mutluluk Testi',
              'Bugün ne kadar mutlusun?',
              '10 soru • 3 dk',
              Icons.emoji_emotions,
            ),
            const SizedBox(height: 16),
            _buildTestCard(
              context, // ← context'i parametre olarak ekledik
              '😰',
              'Kaygı Testi',
              'Kaygı seviyeni ölç',
              '15 soru • 5 dk',
              Icons.psychology,
            ),
            const SizedBox(height: 16),
            _buildTestCard(
              context, // ← context'i parametre olarak ekledik
              '😴',
              'Uyku Kalitesi',
              'Uyku düzenin nasıl?',
              '8 soru • 2 dk',
              Icons.night_shelter,
            ),
            const SizedBox(height: 16),
            _buildTestCard(
              context, // ← context'i parametre olarak ekledik
              '🧘',
              'Stres Testi',
              'Stres seviyeni öğren',
              '12 soru • 4 dk',
              Icons.spa,
            ),
            const SizedBox(height: 16),
            _buildTestCard(
              context, // ← context'i parametre olarak ekledik
              '💪',
              'Özgüven Testi',
              'Kendine güvenini değerlendir',
              '10 soru • 3 dk',
              Icons.fitness_center,
            ),
            const SizedBox(height: 16),
            _buildTestCard(
              context, // ← context'i parametre olarak ekledik
              '❤️',
              'İlişki Testi',
              'İlişki dinamiklerini anla',
              '12 soru • 4 dk',
              Icons.favorite,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestCard(
    BuildContext context, // ← context parametresi eklendi
    String emoji,
    String title,
    String description,
    String duration,
    IconData icon,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: const Color(0xFFF0F7EE),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              emoji,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B4332),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              description,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.timer, size: 14, color: Colors.grey.shade400),
                const SizedBox(width: 4),
                Text(
                  duration,
                  style: TextStyle(color: Colors.grey.shade400, fontSize: 12),
                ),
              ],
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF72B01D).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFF72B01D),
            size: 16,
          ),
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title testi yakında! 📝'),
              backgroundColor: const Color(0xFF72B01D),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    );
  }
}
