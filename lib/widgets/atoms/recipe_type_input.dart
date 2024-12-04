import 'package:flutter/material.dart';

class RecipeTypeInput extends StatefulWidget {
  final Function(String) onTypeSelected;

  const RecipeTypeInput({super.key, required this.onTypeSelected});

  @override
  State<RecipeTypeInput> createState() => _RecipeTypeInputState();
}

class _RecipeTypeInputState extends State<RecipeTypeInput> {
  final List<String> _types = [
    'Végétal',
    'Volaille',
    'Viande Rouge',
    'Gibier',
    'Porc',
    'Poisson/Produit de la mer',
    'Oeufs',
    'Produits laitiers'
  ];

  // Initialisation avec une valeur par défaut
  String _selectedType = 'Végétal';

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text("Type d'apport protéique"),
        DropdownButton<String>(
          value: _selectedType,
          onChanged: (String? newValue) {
            setState(() {
              _selectedType = newValue!;
              widget.onTypeSelected(_selectedType);
            });
          },
          items: _types.map<DropdownMenuItem<String>>((String type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type),
            );
          }).toList(),
        ),
      ],
    );
  }
}
