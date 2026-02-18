import 'package:flutter/material.dart';
import 'home_screen.dart';

// 1. Sayfayı StatefulWidget yaptık ki yazılan ismi hafızada tutabilelim
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 2. İsim ve Soyisim için kontrolcüleri tanımladık
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();

  @override
  void dispose() {
    // 3. Hafıza sızıntısını önlemek için kontrolcüleri temizliyoruz
    _nameController.dispose();
    _surnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F0FF),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF7B61FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 42),
              ),
              const SizedBox(height: 12),
              const Text(
                'Moodify',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF5E35B1)),
              ),
              const Text(
                'Ruh halinizi takip edin, kendinizi keşfedin',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 35),
              // Form Kartı
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Hoş Geldiniz', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const Text('Başlamak için kendinizi tanıtalım', style: TextStyle(color: Colors.grey, fontSize: 14)),
                    const SizedBox(height: 25),
                    
                    // Adınız Girişi (Kontrolcü bağlandı)
                    _inputField("Adınız", "Adınızı girin", _nameController),
                    const SizedBox(height: 16),
                    
                    // Soyadınız Girişi (Kontrolcü bağlandı)
                    _inputField("Soyadınız", "Soyadınızı girin", _surnameController),
                    
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          // 4. "Başlayalım" butonuna basınca ismi alıp HomeScreen'e git
                          if (_nameController.text.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(userName: _nameController.text),
                              ),
                            );
                          } else {
                            // İsim boşsa uyarı verebilirsin
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Lütfen adınızı girin')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7B61FF),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          elevation: 0,
                        ),
                        child: const Text('Başlayalım', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text('Kişisel verileriniz güvende tutulur', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  // 5. InputField fonksiyonuna kontrolcü (controller) parametresi ekledik
  Widget _inputField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF374151))),
        const SizedBox(height: 8),
        TextField(
          controller: controller, // Burası TextField ile kontrolcüyü bağlar
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
          ),
        ),
      ],
    );
  }
}