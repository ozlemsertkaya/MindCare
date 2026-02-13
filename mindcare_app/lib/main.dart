import 'package:flutter/material.dart';
import 'login_screen.dart'; // Tasarımı yaptığımız dosyayı buraya tanıtıyoruz

void main() {
  runApp(const MoodifyApp());
}

class MoodifyApp extends StatelessWidget {
  const MoodifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Sağ üstteki kırmızı bandı kaldırır
      title: 'Moodify',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
      home: const LoginScreen(), // Uygulama açılınca LoginScreen gelsin
    );
  }
}