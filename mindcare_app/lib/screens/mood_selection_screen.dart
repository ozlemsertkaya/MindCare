import 'package:flutter/material.dart';
import 'mood_detail_screen.dart'; // Bu dosyanın adının doğruluğundan emin ol

class MoodSelectionScreen extends StatefulWidget {
  final String userName;
  const MoodSelectionScreen({required this.userName, super.key});

  @override
  State<MoodSelectionScreen> createState() => _MoodSelectionScreenState();
}

class _MoodSelectionScreenState extends State<MoodSelectionScreen> {
  String? selectedMood;
  String? selectedEmoji;

  final List<Map<String, String>> moods = [
    {"emoji": "😢", "label": "Üzgün"},
    {"emoji": "😔", "label": "Kötü"},
    {"emoji": "😐", "label": "Normal"},
    {"emoji": "🙂", "label": "İyi"},
    {"emoji": "😊", "label": "Mutlu"},
    {"emoji": "😁", "label": "Çok İyi"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FDFB),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Bugün Nasıl Hissediyorsunuz?",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4332),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Ruh halinizi seçerek başlayalım",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 25),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: moods.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedMood == moods[index]['label'];
                  return GestureDetector(
                    onTap: () => setState(() {
                      selectedMood = moods[index]['label'];
                      selectedEmoji = moods[index]['emoji'];
                    }),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF00C49A).withValues(alpha: 0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF00C49A)
                              : const Color(0xFFE0F2F1),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            moods[index]['emoji']!,
                            style: const TextStyle(fontSize: 30),
                          ),
                          Text(
                            moods[index]['label']!,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C49A),
                  minimumSize: const Size(double.infinity, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: selectedMood == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MoodDetailScreen(
                              userName: widget.userName,
                              emoji: selectedEmoji!,
                              moodTitle: selectedMood!,
                            ),
                          ),
                        );
                      },
                child: const Text(
                  "Devam Et",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
