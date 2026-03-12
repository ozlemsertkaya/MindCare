import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'mood_selection_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FDFB),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Icon(Icons.spa, color: Color(0xFF52B788), size: 80),
            const Text(
              "MindCare",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B4332),
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "E-posta",
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Şifre",
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF52B788),
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const MoodSelectionScreen(userName: "Rabia"),
                  ),
                );
              },
              child: const Text(
                "Giriş Yap",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RegisterScreen()),
              ),
              child: const Text("Hesabınız yok mu? Kaydolun"),
            ),
          ],
        ),
      ),
    );
  }
}
