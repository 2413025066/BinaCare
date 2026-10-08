import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const BinaCareApp());
}

class BinaCareApp extends StatelessWidget {
  const BinaCareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BinaCare',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2F6FA3),
        ),
        fontFamily: 'Arial',
      ),
      home: const LoginPage(),
    );
  }
}