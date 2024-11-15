import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;
import 'dart:convert'; // For base64 encoding
// Import for image compression (optional)
import 'package:flutter_image_compress/flutter_image_compress.dart';

class RecipePictureInput extends StatefulWidget {
  final Function(String?) onImageSelected;
  const RecipePictureInput({super.key, required this.onImageSelected});

  @override
  State<RecipePictureInput> createState() => _RecipePictureInputState();
}

class _RecipePictureInputState extends State<RecipePictureInput> {
  XFile? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String? _imageBase64;

  get compressedFile => null;

  Future<void> _pickImageMobile() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final compressedFile = await FlutterImageCompress.compressAndGetFile(
          pickedFile.path,
          '${pickedFile.path}_compressed.jpg',
          quality: 80,
        );

        _updateImage((compressedFile ?? File(pickedFile.path)) as File?);
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Future<void> _updateImage(File? imageFile) async {
    setState(() {
      _selectedImage = XFile(imageFile!.path);
    });
    _imageBase64 = base64Encode((await imageFile?.readAsBytes()) as List<int>);

    setState(() {
      widget.onImageSelected(_imageBase64);
      debugPrint('Callback called with _imageBase64 = $_imageBase64');
    });
  }

  Future<void> _pickImageWeb() async {
    try {
      final html.FileUploadInputElement uploadInput =
          html.FileUploadInputElement();
      uploadInput.accept = 'image/*';
      uploadInput.click();

      uploadInput.onChange.listen((e) async {
        final files = uploadInput.files;
        if (files!.isEmpty) return;

        final reader = html.FileReader();
        reader.readAsDataUrl(files[0]);
        reader.onLoadEnd.listen((e) {
          setState(() {
            _imageBase64 =
                reader.result as String?; // Store the base64 image data
            _selectedImage = null; // Clear the mobile file if any
            widget.onImageSelected(_imageBase64);
          });
        });
      });
    } catch (e) {
      debugPrint('Error picking image on web: $e');
    }
  }

  Future<void> _pickImage() async {
    if (kIsWeb) {
      _pickImageWeb(); // If on the web, use the web handler
    } else {
      _pickImageMobile(); // If on mobile, use ImagePicker
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
                        _selectedImage! as File,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
              ),
      ),
    );
  }
}
