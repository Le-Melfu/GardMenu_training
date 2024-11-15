import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class BuildImage extends StatelessWidget {
  final String? base64Image;
  final File? imageFile;
  final double height;
  final double width;
  final BoxFit fit;
  final String? assetPath;

  const BuildImage({
    super.key,
    this.assetPath,
    this.base64Image,
    this.imageFile,
    this.height = 150,
    this.width = double.infinity,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (assetPath != null) {
      return Image(
        image: AssetImage(assetPath!),
        fit: fit,
      );
    } else if (kIsWeb && base64Image != null) {
      try {
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
