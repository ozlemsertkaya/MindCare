import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyScreen extends StatefulWidget {
  const DailyScreen({super.key});

  @override
  State<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  final _entryController = TextEditingController();
  String _selectedMood = '😐';
  bool _isPrivate = false;

  final List<String> _moods = ['😢', '😔', '😐', '🙂', '😊', '😁'];

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    // Türkçe dil desteği için intl paketinin main.dart'ta initialize edilmesi gerekir
    final dateFormat = DateFormat('dd MMMM yyyy, EEEE', 'tr');

    return Scaffold(
      backgroundColor: const Color(0xFFF0F7EE),
      appBar: AppBar(
        title: const Text(
          'Günlük',
          style: TextStyle(color: Color(0xFF1B4332)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF72B01D)),
        actions: [
          IconButton(
            icon: const Icon(Icons.history, color: Color(0xFF72B01D)),
            onPressed: _showHistory,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateHeader(dateFormat, now),
            const SizedBox(height: 24),
            const Text(
              'Ruh Halin',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B4332)),
            ),
            const SizedBox(height: 12),
            _buildMoodSelector(),
            const SizedBox(height: 20),
            _buildEntryField(),
            const SizedBox(height: 16),
            _buildPrivacySwitch(),
            const SizedBox(height: 24),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateHeader(DateFormat format, DateTime now) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFF72B01D), Color(0xFF8BC34A)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(format.format(now),
              style: const TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 4),
          const Text('Bugün nasıl hissediyorsun?',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMoodSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _moods.map((mood) {
          final isSelected = _selectedMood == mood;
          return GestureDetector(
            onTap: () => setState(() => _selectedMood = mood),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                // HATA DÜZELTME: withOpacity yerine withValues kullanıldı
                color: isSelected
                    ? const Color(0xFF72B01D).withValues(alpha: 0.1)
                    : null,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: isSelected
                        ? const Color(0xFF72B01D)
                        : Colors.transparent),
              ),
              child: Text(mood, style: const TextStyle(fontSize: 24)),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildEntryField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Günlük Girişin',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1B4332))),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: TextField(
            controller: _entryController,
            maxLines: 8,
            decoration: const InputDecoration(
              hintText: 'Bugün neler yaşadın?',
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrivacySwitch() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Icon(_isPrivate ? Icons.lock : Icons.lock_open,
              color: const Color(0xFF72B01D)),
          const SizedBox(width: 12),
          const Expanded(
              child: Text('Bu girişi özel yap',
                  style: TextStyle(color: Color(0xFF1B4332)))),
          Switch(
            value: _isPrivate,
            onChanged: (value) => setState(() => _isPrivate = value),
            activeThumbColor: const Color(0xFF72B01D),
          ),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF72B01D),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: () {
          if (_entryController.text.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text('Günlük kaydedildi! 📝'),
                  backgroundColor: Color(0xFF72B01D),
                  behavior: SnackBarBehavior.floating),
            );
            _entryController.clear();
          }
        },
        child: const Text('Günlüğü Kaydet',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  void _showHistory() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        height: 400,
        child: Column(
          children: [
            const Text('Geçmiş Günlükler',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => ListTile(
                  leading: const Text('😊', style: TextStyle(fontSize: 24)),
                  title: Text('${index + 10} Mart 2026'),
                  onTap: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
