import 'package:finsire/view/home_page.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const ReaderStatsApp());
}

class ReaderStatsApp extends StatelessWidget {
  const ReaderStatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReaderStatsScreen(),
    );
  }
}
