import 'package:flutter/material.dart';

class PageMenuGenerator extends StatelessWidget {
  const PageMenuGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Générateur de menu'),
      ),
      body: const Center(
        child: Text('Page Générateur de menu'),
      ),
    );
  }
}