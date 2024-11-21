import 'package:flutter/material.dart';
import 'package:gardmenu_training/models/ingredient_model.dart';

class RecipeIngredientInput extends StatefulWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  String selectedUnit = 'g';

  RecipeIngredientInput({super.key});

  Ingredient get ingredient {
    final name = nameController.text;
    final quantity = double.tryParse(quantityController.text) ?? 0.0;
    final measureUnit = selectedUnit;
    return Ingredient(name: name, quantity: quantity, measureUnit: measureUnit);
  }

  @override
  State<RecipeIngredientInput> createState() => _RecipeIngredientInputState();
}

class _RecipeIngredientInputState extends State<RecipeIngredientInput> {
  // Liste des unités de mesure
  final List<String> _units = ['g', 'ml', 'càc', 'càs', ''];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Champ Nom de l'ingrédient
            Expanded(
              flex: 2,
              child: TextField(
                controller: widget.nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom de l\'ingrédient',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Champ Quantité
            Expanded(
              flex: 1,
              child: TextField(
                controller: widget.quantityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantité',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 8),

            // Menu déroulant pour l'unité de mesure
            DropdownButton<String>(
              value: widget.selectedUnit,
              onChanged: (String? newValue) {
                setState(() {
                  widget.selectedUnit = newValue!;
                });
              },
              items: _units.map<DropdownMenuItem<String>>((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
