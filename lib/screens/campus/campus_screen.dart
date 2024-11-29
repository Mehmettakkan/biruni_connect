import 'package:flutter/material.dart';

class CampusScreen extends StatelessWidget {
  const CampusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kampüs'),
      ),
      body: const Center(
        child: Text('Kampüs Haritası'),
      ),
    );
  }
}
