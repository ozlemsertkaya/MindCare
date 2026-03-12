import 'package:flutter/material.dart';
import 'home_screen.dart'; // Ana sayfaya gitmek için

class MoodDetailScreen extends StatelessWidget {
  final String userName;
  final String emoji;
  final String moodTitle;

  const MoodDetailScreen({
    super.key,
    required this.userName,
    required this.emoji,
    required this.moodTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "İyi günler, $userName",
          style: const TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Üst Kart
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF7B61FF),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Text(emoji, style: const TextStyle(fontSize: 50)),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Bugünün Ruh Hali',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '$moodTitle görünüyorsun! Bu enerjiyi koru.',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("Günün Kurabiyesi"),
            _buildInfoCard("🍪", "Kurabiyeyi kır ve günün mesajını al!"),
            const SizedBox(height: 20),
            _buildSectionTitle("Ruh Haline Özel Müzikler"),
            _buildMusicTile("Happy", "Pharrell Williams"),
            _buildMusicTile("Walking on Sunshine", "Katrina & Waves"),
            const SizedBox(height: 30),
            // ANA SAYFAYA GEÇİŞ BUTONU
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF52B788),
                minimumSize: const Size(double.infinity, 55),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(userName: userName),
                  ),
                  (route) => false,
                );
              },
              child: const Text(
                "Uygulamaya Başla",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String icon, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 10),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildMusicTile(String title, String artist) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: const Icon(Icons.music_note, color: Colors.purple),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(artist),
        trailing: const Icon(Icons.play_circle_fill, color: Colors.purple),
      ),
    );
  }
}
