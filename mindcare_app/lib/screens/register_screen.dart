import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'info_screens.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = AuthService();
  bool _isLoading = false;

  void _handleRegister() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bilgileri kontrol edin!")),
      );
      return;
    }

    setState(() => _isLoading = true);
    
    final user = await _auth.registerWithEmail(
      _emailController.text.trim(),
      _passwordController.text.trim(),
    );

    if (user != null) {
      // İsmi Firebase'e kaydeden kısım
      await user.updateDisplayName(_nameController.text.trim());
      await user.reload();
      
      if (mounted) {
        // Kayıt başarılıysa sonraki ekrana geçer
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => InfoFlowScreen(userName: _nameController.text),
          ),
          (route) => false,
        );
      }
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Kayıt Ol")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Ad Soyad"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "E-posta"),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Şifre"),
            ),
            const SizedBox(height: 30),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF52B788),
                      minimumSize: const Size(double.infinity, 55),
                    ),
                    onPressed: _handleRegister,
                    child: const Text(
                      "Kayıt Ol ve Devam Et",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}