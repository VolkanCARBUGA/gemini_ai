import 'package:flutter/material.dart';
import 'package:gemini_ai/onboarding.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Splash screen'in gösterilme süresi (örneğin, 3 saniye)
    Future.delayed(const Duration(seconds: 5), () {
      // Ana sayfaya geçiş
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Onboarding()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: const Color.fromRGBO(68, 138, 255, 1),
      body: Center(
        child: Image.asset('assets/splashscreen.png',color: Colors.white), // Burada logonuzu kullanabilirsiniz
      ),
    );
  }
}
