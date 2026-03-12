import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:mindcare_app/screens/login_screen.dart';
import 'package:mindcare_app/screens/home_screen.dart';
import 'package:mindcare_app/screens/activiteler_screen.dart';
import 'package:mindcare_app/screens/testler_screen.dart';
import 'package:mindcare_app/screens/gunluk_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MindCareApp());
}

class MindCareApp extends StatelessWidget {
  const MindCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MindCare',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF52B788),
      ),
      initialRoute: '/',
      // Rotaları (Routes) parametre hatalarını gidermek için güncelledik
      routes: {
        '/': (context) => const LoginScreen(),
        // HomeScreen artık userName beklediği için varsayılan bir isim ekledik
        '/home': (context) => const HomeScreen(userName: "Rabia"),
        '/aktiviteler': (context) => const AktivitelerScreen(),
        '/testler': (context) => const TestlerScreen(),
        '/gunluk': (context) => const GunlukScreen(),
      },
    );
  }
}
