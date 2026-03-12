import 'package:flutter/material.dart';
import 'home_screen.dart';

class InfoFlowScreen extends StatefulWidget {
  final String userName;
  const InfoFlowScreen({required this.userName, super.key});

  @override
  State<InfoFlowScreen> createState() => _InfoFlowScreenState();
}

class _InfoFlowScreenState extends State<InfoFlowScreen> {
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F2F1),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _currentPage == 0 ? _buildFirstPage() : _buildSecondPage(),
              const SizedBox(height: 30),
              Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => _currentPage = 0),
                        child: const Text("Geri"),
                      ),
                    ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00C49A),
                      ),
                      onPressed: () {
                        if (_currentPage == 0) {
                          setState(() => _currentPage = 1);
                        } else {
                          // Seçilen kullanıcı ismiyle ana sayfaya bağlar
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(userName: widget.userName),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      child: Text(
                        _currentPage == 0 ? "İleri" : "Başlayalım! 🚀",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFirstPage() {
    return Column(
      children: [
        const Text(
          "Size Yardımcı Olalım",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Wrap(
          // Wrap kullanarak tümünü ekrana sığdırdık
          spacing: 15,
          runSpacing: 15,
          alignment: WrapAlignment.center,
          children: [
            _infoBox("😌", "Stres"),
            _infoBox("😊", "Mutluluk"),
            _infoBox("😴", "Uyku"),
            _infoBox("🧘", "Farkındalık"),
          ],
        ),
      ],
    );
  }

  Widget _buildSecondPage() {
    return Column(
      children: [
        const Icon(Icons.check_circle, color: Color(0xFF00C49A), size: 70),
        const SizedBox(height: 20),
        const Text(
          "Hazırsınız!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          widget.userName,
          style: const TextStyle(
            fontSize: 20,
            color: Color(0xFF00C49A),
            fontWeight: FontWeight.bold,
          ),
        ), // Dinamik isim
        const SizedBox(height: 10),
        const Text(
          "Sizin için kişiselleştirilmiş bir deneyim hazırladık.",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _infoBox(String emo, String txt) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFF1FBF9),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.teal.shade100),
      ),
      child: Column(
        children: [
          Text(emo, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 5),
          Text(txt, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
