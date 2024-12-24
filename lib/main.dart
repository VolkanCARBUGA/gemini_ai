import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gemini_ai/onboarding.dart';
import 'package:gemini_ai/splash_screen.dart';
import 'package:gemini_ai/theme_notifier.dart';
import 'package:gemini_ai/themes.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final themeMode=ref.watch(themeProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
    darkTheme: darkMode,
    theme: lightMode,
    themeMode: themeMode,
      home:Onboarding()
    );
  }
}

