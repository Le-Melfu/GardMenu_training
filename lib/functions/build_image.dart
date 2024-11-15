import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class BuildImage extends StatelessWidget {
  final String? base64Image; // Make base64Image nullable
  final File? imageFile; // Add imageFile for mobile
  final double height;
  final double width;
  final BoxFit fit;

  const BuildImage({
    super.key,
    this.base64Image,
    this.imageFile,
    this.height = 150,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb && base64Image != null) {
      try {
        // Décodage de l'image en base64 pour le web
        final decodedBytes = base64Decode(base64Image!.split(',').last);
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
    } else if (!kIsWeb && imageFile != null) {
      // Affichage de l'image à partir d'un fichier pour mobile
      return Image.file(
        imageFile!,
        fit: fit,
        height: height,
        width: width,
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.broken_image, size: 150);
        },
      );
    } else {
      // Cas par défaut si aucune image n'est fournie
      return const Icon(Icons.broken_image, size: 150);
    }
  }
}
