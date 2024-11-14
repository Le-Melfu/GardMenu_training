import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;
import 'dart:convert'; // For base64 encoding

class RecipePictureInput extends StatefulWidget {
  const RecipePictureInput({Key? key}) : super(key: key);

  @override
  State<RecipePictureInput> createState() => _RecipePictureInputState();
}

class _RecipePictureInputState extends State<RecipePictureInput> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String? _imageBase64;

  // Méthode pour sélectionner une image (mobile)
  Future<void> _pickImageMobile() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path); // Stockage de l'image sélectionnée
        _imageBase64 = null; // Clear the base64 image for mobile
      });
    }
  }

  // Méthode pour sélectionner une image (web)
  Future<void> _pickImageWeb() async {
    final html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*'; // Seulement les images
    uploadInput.click(); // Ouvre la boîte de dialogue pour sélectionner un fichier

    uploadInput.onChange.listen((e) async {
      final files = uploadInput.files;
      if (files!.isEmpty) return;

      final reader = html.FileReader();
      reader.readAsDataUrl(files[0]); // Read as data URL for base64 encoding
      reader.onLoadEnd.listen((e) {
        setState(() {
          _imageBase64 = reader.result as String?; // Store the base64 image data
          _selectedImage = null; // Clear the mobile file if any
        });
      });
    });
  }

  // Méthode pour gérer l'ajout d'image, en fonction de la plateforme
  Future<void> _pickImage() async {
    if (kIsWeb) {
      _pickImageWeb(); // Si sur le web, utiliser le gestionnaire web
    } else {
      _pickImageMobile(); // Si sur mobile, utiliser ImagePicker
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: double.infinity,
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: _selectedImage == null && _imageBase64 == null
            ? const Center(
          child: Text(
            'Ajouter une image',
            style: TextStyle(color: Colors.black54),
          ),
        )
            : ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: kIsWeb
              ? _imageBase64 == null
              ? const SizedBox()
              : Image.memory(
            // Remove base64 header before decoding
            base64Decode(_imageBase64!.split(',').last),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          )
              : Image.file(
            _selectedImage!,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
    );
  }
}
