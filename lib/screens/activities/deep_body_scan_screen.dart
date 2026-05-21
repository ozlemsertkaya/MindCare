import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:google_fonts/google_fonts.dart';

class DeepBodyScanScreen extends StatefulWidget {
  const DeepBodyScanScreen({super.key});

  @override
  State<DeepBodyScanScreen> createState() => _DeepBodyScanScreenState();
}

class _DeepBodyScanScreenState extends State<DeepBodyScanScreen> {
  int currentStep = 0;
  bool _sessionStarted = false;
  bool _isPaused = false;

  Timer? timer;
  late int remainingSeconds;

  // Sesin tam süresi: 1:36 = 96 Saniye
  final int totalAudioDuration = 96; 

  final AudioPlayer player = AudioPlayer();

  // Tasarımınıza uygun soft yeşil tonları listesi
  final List<Color> bodyColors = [
    const Color(0xFF10B981), // Canlı Meditasyon Yeşili
    const Color(0xFF064E3B), // Derin Koyu Yeşil
    const Color(0xFF34D399), // Soft Nane Yeşili
    const Color(0xFF6EE7B7), // Açık Adaçayı Yeşili
    const Color(0xFF059669), // Zümrüt Yeşili
    const Color(0xFFA7F3D0), // Çok Soft Yeşil
  ];

  // Sesin kronolojik akışına (kalan saniyeye) göre adımlar
  final List<Map<String, dynamic>> steps = [
    {
      "title": "Giriş ve Nefes",
      "desc": "Rahat bir pozisyona geçin ve nefesinize odaklanın.",
      "emoji": "🧘",
      "startSecond": 96,
    },
    {
      "title": "Ayaklar ve Bacaklar",
      "desc": "Ayak parmaklarınızı ve tabanlarınızı hissedin, ağırlığı bırakın.",
      "emoji": "🦶",
      "startSecond": 77,
    },
    {
      "title": "Gövde ve Nefes",
      "desc": "Nefes alırken karnınızın yükselişini ve düşüşünü izleyin.",
      "emoji": "🫁",
      "startSecond": 56,
    },
    {
      "title": "Omuzlar ve Kollar",
      "desc": "Omuzlarınızı serbest bırakın, kollarınız gevşesin.",
      "emoji": "💪",
      "startSecond": 42,
    },
    {
      "title": "Yüz ve Baş Bölgesi",
      "desc": "Çenenizi, göz çevrenizi ve alnınızı tamamen rahatlatın.",
      "emoji": "😊",
      "startSecond": 32,
    },
    {
      "title": "Tüm Beden ve Kapanış",
      "desc": "Tüm bedeninizi tek bir bütün olarak hissedin. Sakin ve güvende.",
      "emoji": "✨",
      "startSecond": 19,
    },
  ];

  @override
  void initState() {
    super.initState();
    _resetSessionValues();
  }

  void _resetSessionValues() {
    remainingSeconds = totalAudioDuration;
    currentStep = 0;
    _isPaused = false;
  }

  Future<void> startMeditationAudio() async {
    try {
      await player.setReleaseMode(ReleaseMode.stop);
      await player.play(UrlSource('assets/audio/voice_preview_vucut_taramasi.mp3'));
    } catch (e) {
      debugPrint("Audio error: $e");
    }
  }

  Future<void> stopMeditationAudio() async {
    await player.stop();
  }

  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted || _isPaused) return;

      if (remainingSeconds <= 0) {
        t.cancel();
        showFinishDialog();
        return;
      }

      setState(() {
        remainingSeconds--;
        _updateStepBasedOnTime(remainingSeconds);
      });
    });
  }

  void _updateStepBasedOnTime(int secondsLeft) {
    for (int i = 0; i < steps.length; i++) {
      if (i == steps.length - 1) {
        currentStep = i;
        break;
      }
      if (secondsLeft <= steps[i]["startSecond"] && secondsLeft > steps[i + 1]["startSecond"]) {
        currentStep = i;
        break;
      }
    }
  }

  void restart() async {
    timer?.cancel();
    await stopMeditationAudio();
    setState(() {
      _sessionStarted = false;
      _resetSessionValues();
    });
  }

  void showFinishDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.spa_rounded, size: 65, color: Color(0xFF10B981)),
              const SizedBox(height: 16),
              Text(
                "Seans Tamamlandı",
                style: GoogleFonts.nunito(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF064E3B),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    restart();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF10B981), // Canlı Yeşil Ana Buton
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: Text(
                    "Tekrar Başla",
                    style: GoogleFonts.nunito(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '$m:${s.toString().padLeft(2, "0")}';
  }

  @override
  void dispose() {
    timer?.cancel();
    player.stop();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final step = steps[currentStep];
    final currentColor = bodyColors[currentStep % bodyColors.length];
    
    int currentStepTotalSec = (currentStep == steps.length - 1) 
        ? steps[currentStep]["startSecond"]
        : (steps[currentStep]["startSecond"] - steps[currentStep + 1]["startSecond"]) as int;
    int currentStepElapsed = steps[currentStep]["startSecond"] - remainingSeconds;
    double phaseProgress = (currentStepElapsed / currentStepTotalSec).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: const Color(0xFFF0FDF4),
      appBar: AppBar(
        backgroundColor: const Color(0xFF10B981),
        foregroundColor: Colors.white,
        title: Text(
          "Beden Tarama",
          style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: !_sessionStarted
          ? Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      setState(() {
                        _sessionStarted = true;
                        _resetSessionValues();
                      });
                      await startMeditationAudio();
                      startTimer();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF10B981), // Giriş ekranı ana butonu
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 2,
                    ),
                    icon: const Icon(Icons.play_arrow_rounded, size: 28),
                    label: Text(
                      "Meditasyonu Başlat",
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Text(
                    formatTime(remainingSeconds),
                    style: GoogleFonts.nunito(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF064E3B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    step["title"]!,
                    style: GoogleFonts.nunito(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: currentColor,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: Center(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final size = constraints.maxWidth * 0.75;

                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: size,
                                height: size,
                                child: CircularProgressIndicator(
                                  value: 1.0,
                                  strokeWidth: 8,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    const Color(0xFF10B981).withOpacity(0.1),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size,
                                height: size,
                                child: CircularProgressIndicator(
                                  value: remainingSeconds / totalAudioDuration,
                                  strokeWidth: 10,
                                  strokeCap: StrokeCap.round,
                                  valueColor: AlwaysStoppedAnimation<Color>(currentColor),
                                ),
                              ),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: size * (0.65 + phaseProgress * 0.15),
                                height: size * (0.65 + phaseProgress * 0.15),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentColor.withOpacity(0.12),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      step["emoji"]!,
                                      style: const TextStyle(fontSize: 44),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      formatTime(remainingSeconds),
                                      style: GoogleFonts.nunito(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w800,
                                        color: currentColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      step["desc"]!,
                      style: GoogleFonts.nunito(
                        fontSize: 15,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // KONTROL BUTONLARI (Renk oyunundaki şema ile birebir eşitlendi)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              setState(() => _isPaused = !_isPaused);
                              if (_isPaused) {
                                timer?.cancel();
                                await player.pause();
                              } else {
                                await player.resume();
                                startTimer();
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isPaused
                                  ? const Color(0xFF10B981) // Duraklatıldığında dikkat çeken canlı yeşil
                                  : const Color(0xFFD1FAE5), // Normal süreçte soft yeşil arka plan
                              foregroundColor: _isPaused
                                  ? Colors.white
                                  : const Color(0xFF047857),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: Icon(_isPaused ? Icons.play_arrow : Icons.pause),
                            label: Text(
                              _isPaused ? "Devam Et" : "Duraklat",
                              style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () async {
                              timer?.cancel();
                              await stopMeditationAudio();
                              Navigator.pop(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF047857), // Net bitiriş için koyu yeşil tonu
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.close),
                            label: Text(
                              "Seansı Bitir",
                              style: GoogleFonts.nunito(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}