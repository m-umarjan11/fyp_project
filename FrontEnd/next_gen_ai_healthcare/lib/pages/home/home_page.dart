import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:next_gen_ai_healthcare/pages/auth/splash_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(
            surface: Colors.grey.shade100,
            onSurface: Colors.black,
            primary: Colors.blue,
            onPrimary: Colors.white),
      ),
      home: const SplashPage(),
    );
  }
}