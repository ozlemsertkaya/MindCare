import 'package:flutter/material.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({required this.userName, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FDFB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Günaydın",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            Text(
              widget.userName,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const CircleAvatar(
              backgroundColor: Color(0xFFE0F2F1),
              child: Icon(Icons.person, color: Color(0xFF52B788)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF52B788),
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: "Ana Sayfa",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bakery_dining),
            label: "Aktiviteler",
          ), // Hata burada düzeltildi
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Testler",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Günlük"),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Analiz"),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMoodCard(),
          const SizedBox(height: 20),
          _buildFortuneCookie(),
          const SizedBox(height: 20),
          const Text(
            "Ruh Haline Özel Müzikler",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          _buildMusicTile("Neşeli Akustik", "Huzurlu ve enerjik"),
          _buildMusicTile("Pozitif Enerji", "Güne başlarken"),
        ],
      ),
    );
  }

  Widget _buildMoodCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE0F2F1)),
      ),
      child: Row(
        children: [
          const Text("😊", style: TextStyle(fontSize: 40)),
          const SizedBox(width: 15),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Bugünün Ruh Hali",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "Harika görünüyorsun!",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildFortuneCookie() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Icon(Icons.cookie, color: Colors.orange, size: 24),
              SizedBox(width: 10),
              Text(
                "Günün Kurabiyesi",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Icon(Icons.cookie, size: 80, color: Colors.orangeAccent),
          const SizedBox(height: 10),
          const Text(
            "Kurabiyeyi kır ve günün mesajını al!",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildMusicTile(String title, String subtitle) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Color(0xFFF0F0F0)),
      ),
      child: ListTile(
        leading: const Icon(Icons.music_note, color: Color(0xFF52B788)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.play_circle_fill, color: Color(0xFF52B788)),
      ),
    );
  }
}
