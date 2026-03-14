import 'package:flutter/material.dart';
import 'activities_screen.dart';
import 'tests_screen.dart';
import 'daily_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  final String userEmoji;

  const HomeScreen({
    required this.userName,
    required this.userEmoji,
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isCookieBroken = false;
  String _cookieMessage = "Kurabiyeyi kır ve günün mesajını al!";

  final List<String> _messages = const [
    "Bugün senin günün! ✨",
    "Kendine güven, her şey güzel olacak 🌿",
    "Küçük mutluluklar seni bekliyor 🍀",
    "Zihnini dinlendir, yenilen 🧘",
    "Sevgiyle kal, mutluluk seni bulacak 💚",
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() => _selectedIndex = index);

    switch (index) {
      case 1:
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => const ActivitiesScreen()));
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const TestsScreen()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const DailyScreen()));
        break;
      case 4:
        _showSnackBar("Analiz yakında! 📊");
        break;
    }
  }

  void _breakCookie() {
    if (!_isCookieBroken) {
      final randomMessage = _messages[_messages.length ~/ 2];
      setState(() {
        _isCookieBroken = true;
        _cookieMessage = randomMessage;
      });
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _isCookieBroken = false;
            _cookieMessage = "Kurabiyeyi kır ve günün mesajını al!";
          });
        }
      });
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF72B01D),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7EE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Hoş Geldin',
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text(
              widget.userName,
              style: const TextStyle(
                color: Color(0xFF1B4332),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F7EE),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(widget.userEmoji, style: const TextStyle(fontSize: 20)),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Color(0xFF72B01D)),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SettingsScreen()),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _buildMoodCard(),
            const SizedBox(height: 20),
            _buildCookieCard(),
            const SizedBox(height: 20),
            _buildSectionTitle('Ruh Haline Özel'),
            const SizedBox(height: 10),
            _buildMusicItem('Huzurlu Orman', 'Doğa Sesleri', '45dk'),
            _buildMusicItem('Odaklanma', 'Lo-fi Beats', '60dk'),
            _buildMusicItem('Derin Meditasyon', 'Binaural', '30dk'),
            const SizedBox(height: 20),
            _buildSectionTitle('Hızlı Aktiviteler'),
            const SizedBox(height: 10),
            _buildActivityGrid(),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildMoodCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F7EE),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(widget.userEmoji, style: const TextStyle(fontSize: 30)),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bugünün Ruh Hali',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 4),
                Text(
                  'Kendine iyi bak, her şey yolunda.',
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios,
              color: Color(0xFF72B01D), size: 16),
        ],
      ),
    );
  }

  Widget _buildCookieCard() {
    return GestureDetector(
      onTap: _breakCookie,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                _isCookieBroken ? const Color(0xFF72B01D) : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            const Text(
              '🍪 Günün Kurabiyesi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 15),
            Icon(
              _isCookieBroken ? Icons.auto_awesome : Icons.cookie,
              size: 60,
              color: const Color(0xFF72B01D),
            ),
            const SizedBox(height: 10),
            Text(
              _cookieMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B4332),
          ),
        ),
        TextButton(
          onPressed: () {},
          child: const Text('Tümünü Gör',
              style: TextStyle(color: Color(0xFF72B01D))),
        ),
      ],
    );
  }

  Widget _buildMusicItem(String title, String subtitle, String duration) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: const Icon(Icons.music_note, color: Color(0xFF72B01D)),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F7EE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(duration, style: const TextStyle(fontSize: 12)),
        ),
      ),
    );
  }

  Widget _buildActivityGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: [
        _buildActivityItem(Icons.self_improvement, 'Meditasyon'),
        _buildActivityItem(Icons.library_music, 'Müzik'),
        _buildActivityItem(Icons.assignment, 'Test'),
        _buildActivityItem(Icons.book, 'Günlük'),
      ],
    );
  }

  Widget _buildActivityItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon, color: const Color(0xFF72B01D)),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF72B01D),
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Sayfa'),
        BottomNavigationBarItem(
            icon: Icon(Icons.self_improvement), label: 'Aktiviteler'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Testler'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Günlük'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Analiz'),
      ],
    );
  }
}
