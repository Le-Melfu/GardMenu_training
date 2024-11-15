import 'package:flutter/material.dart';

class TextCardWidget extends StatelessWidget {
  final String text;

  const TextCardWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 255, 146, 106),
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
