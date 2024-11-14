import 'dart:convert';
import 'package:flutter/material.dart';

class BuildImage extends StatelessWidget {
  final String base64Image;
  final double height;
  final double width;
  final BoxFit fit;

  const BuildImage({
    super.key,
    required this.base64Image,
    this.height = 150,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    try {
      // Décodage de l'image en base64
      final decodedBytes = base64Decode(base64Image);
      return Image.memory(
        decodedBytes,
        fit: fit,
        height: height,
        width: width,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 150);
        },
      );
    } catch (e) {
      // Affichage de l'erreur dans la console pour le debug
      debugPrint('Erreur de décodage de l\'image : $e');
      return const Icon(Icons.broken_image, size: 150);
    }
  }
}