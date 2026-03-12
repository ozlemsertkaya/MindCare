import 'package:flutter/material.dart';

class GunlukScreen extends StatelessWidget {
  const GunlukScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Günlüğüm")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: "Bugünün başlığı...",
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const Expanded(
              child: TextField(
                maxLines: null,
                decoration: InputDecoration(
                  hintText: "Neler oldu? Nasıl hissediyorsun?",
                  border: InputBorder.none,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF52B788),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Kaydet",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
