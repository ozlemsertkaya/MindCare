import 'package:flutter/material.dart';

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
        title: Text("İyi günler, $userName", style: const TextStyle(color: Colors.black, fontSize: 16)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // 1. Bugünün Ruh Hali Kartı
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
                        const Text('Bugünün Ruh Hali', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        Text('$moodTitle görünüyorsun! Bu enerjiyi koru.', 
                          style: const TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // 2. Günün Kurabiyesi
            _buildInfoCard("Günün Kurabiyesi", "🍪", "Kurabiyeyi kır ve günün mesajını al!"),
            const SizedBox(height: 20),
            // 3. Müzik Önerileri
            _buildMusicSection(emoji),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String icon, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), 
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)]),
      child: Column(
        children: [
          Row(children: [Text(icon), const SizedBox(width: 10), Text(title, style: const TextStyle(fontWeight: FontWeight.bold))]),
          const SizedBox(height: 20),
          const Icon(Icons.cookie, size: 80, color: Colors.orange),
          const SizedBox(height: 10),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildMusicSection(String currentEmoji) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Ruh Haline Özel Müzikler", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text("$currentEmoji haline göre seçildi", style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 15),
        _buildMusicTile("Happy", "Pharrell Williams", "Pop"),
        _buildMusicTile("Good Vibrations", "The Beach Boys", "Pop Rock"),
        _buildMusicTile("Walking on Sunshine", "Katrina and the Waves", "Pop"),
      ],
    );
  }

  Widget _buildMusicTile(String title, String artist, String genre) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.purple.shade50, borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.music_note, color: Colors.purple),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(artist, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Text(genre, style: const TextStyle(color: Colors.purple, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}