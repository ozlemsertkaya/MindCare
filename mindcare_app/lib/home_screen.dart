import 'package:flutter/material.dart';
import 'mood_detail_screen.dart'; 

class HomeScreen extends StatefulWidget {
  final String userName;

  HomeScreen({required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Seçilen emojiyi tutacak değişken (Başlangıçta boş veya bir varsayılan)
  String selectedEmoji = "❓"; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Üst Kısım: İsim ve Seçilen Emoji + Profil
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('İyi günler', style: TextStyle(color: Colors.grey, fontSize: 14)),
                      Text(widget.userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  // Sağ Üst Alan: Emoji ve Profil Yanyana
                  Row(
                    children: [
                      // Seçilen Emoji Buraya Gelecek
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                        ),
                        child: Text(selectedEmoji, style: const TextStyle(fontSize: 20)),
                      ),
                      const SizedBox(width: 10),
                      const CircleAvatar(
                        backgroundColor: Color(0xFF7B61FF),
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Center(
                child: Column(
                  children: [
                    Text('Bugün nasıl hissediyorsun?', 
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A237E))),
                    SizedBox(height: 8),
                    Text('Ruh halinizi seçin', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // Emoji Grid Yapısı
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.3,
                  children: [
                    _moodCard("Çok Üzgün", "😢"),
                    _moodCard("Üzgün", "😔"),
                    _moodCard("Normal", "😐"),
                    _moodCard("İyi", "😊"),
                    _moodCard("Mutlu", "😁"),
                    _moodCard("Çok Mutlu", "🤩"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF7B61FF),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Ana Sayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.auto_graph), label: 'Aktiviteler'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Testler'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Günlük'),
        ],
      ),
    );
  }

  // Tıklanabilir Emoji Kartı
  // ... üst kısımlar aynı ...

  // Tıklanabilir Emoji Kartı - Bu fonksiyonun _HomeScreenState içinde olduğundan emin ol
  Widget _moodCard(String title, String emoji) {
    return GestureDetector(
      onTap: () {
        // 1. Önce ana sayfadaki (sağ üstteki) emojiyi güncelle
        setState(() {
          selectedEmoji = emoji;
        });

        // 2. Sonra detay sayfasına (müzikli/kurabiyeli ekran) git ve verileri gönder
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoodDetailScreen(
              userName: widget.userName,
              emoji: emoji,
              moodTitle: title,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            // Seçilen emojinin etrafını mor yaparak görsel geri bildirim verir
            color: selectedEmoji == emoji ? const Color(0xFF7B61FF) : const Color(0xFFE0E0E0).withOpacity(0.5),
            width: selectedEmoji == emoji ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02), 
              blurRadius: 10, 
              offset: const Offset(0, 4)
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 10),
            Text(
              title, 
              style: const TextStyle(
                fontWeight: FontWeight.w600, 
                color: Color(0xFF374151)
              )
            ),
          ],
        ),
      ),
    );
  }
  }