import 'package:flutter/material.dart';

ButtonStyle getCustomElevatedButtonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: Color.fromARGB(255, 4, 139, 154), // Background color
    foregroundColor: Colors.white, // Text color
    textStyle: const TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold), // Text style
    padding:
        const EdgeInsets.symmetric(horizontal: 20, vertical: 12), // Padding
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14), // Button shape
    ),
  );
}
