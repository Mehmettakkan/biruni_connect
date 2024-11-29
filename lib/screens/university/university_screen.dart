import 'package:flutter/material.dart';

class UniversityScreen extends StatelessWidget {
  const UniversityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Üniversite'),
      ),
      body: const Center(
        child: Text('Üniversite Bilgileri'),
      ),
    );
  }
}
