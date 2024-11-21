import 'package:flutter/material.dart';
import 'package:gardmenu_training/models/ingredient_model.dart';
import 'package:gardmenu_training/models/recipe_model.dart';
import 'package:gardmenu_training/providers/recipes_provider.dart';
import 'package:gardmenu_training/widgets/atoms/recipe_image_input.dart';
import 'package:gardmenu_training/widgets/atoms/recipe_ingredient_input.dart';
import 'package:gardmenu_training/widgets/atoms/recipe_steps_input.dart';
import 'package:provider/provider.dart';

class RecipeModal extends StatefulWidget {
  const RecipeModal({super.key});

  @override
  State<RecipeModal> createState() => _RecipeModalState();
}

class _RecipeModalState extends State<RecipeModal> {
  final TextEditingController _nameController = TextEditingController();
  final List<RecipeIngredientInput> _ingredients = [RecipeIngredientInput()];
  final List<RecipeStepInput> _steps = [RecipeStepInput(stepNumber: 1)];
  String? _imageBase64;
  bool _validationError = false;

  void _handleImageSelected(String? base64Image) {
    setState(() {
      _imageBase64 = base64Image;
    });
  }

  // Ajout d'un input d'ingrédient
  void _addIngredient() {
    setState(() {
      _ingredients.add(RecipeIngredientInput());
    });
  }

  // Ajout d'une étape de recette
  void _addStep() {
    setState(() {
      _steps.add(RecipeStepInput(stepNumber: _steps.length + 1));
    });
  }

  bool _validateInputs() {
    if (_nameController.text.isEmpty) {
      return false;
    }

    bool hasValidIngredients = _ingredients.any((input) {
      return input.nameController.text.isNotEmpty &&
          input.quantityController.text.isNotEmpty;
    });

    if (!hasValidIngredients) {
      return false;
    }

    bool hasValidSteps = _steps.any((input) {
      return input.controller.text.isNotEmpty;
    });

    if (!hasValidSteps) {
      return false;
    }

    return true;
  }

  // Méthode d'ajout d'une recette avec construction de la nouvelle recette
  void _addRecipe() {
    if (_validateInputs()) {
      final recipe = Recipe(
        name: _nameController.text,
        ingredients: _ingredients
            .where((input) =>
                input.nameController.text.isNotEmpty &&
                input.quantityController.text.isNotEmpty)
            .map((input) {
          final name = input.nameController.text;
          final quantity =
              double.tryParse(input.quantityController.text) ?? 0.0;
          final measureUnit = input.selectedUnit;
          return Ingredient(
              name: name, quantity: quantity, measureUnit: measureUnit);
        }).toList(),
        steps: _steps
            .where((input) => input.controller.text.isNotEmpty)
            .map((input) => input.controller.text)
            .toList(),
        image: _imageBase64,
      );

      // Add the recipe to the provider
      Provider.of<RecipeProvider>(context, listen: false).addRecipe(recipe);
      Navigator.of(context).pop();
    } else {
      setState(() {
        _validationError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // Input du nom de la recette
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nom du plat *',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Section Ingredients
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // Input des ingrédients avec le bouton d'ajout pour plusieurs ingrédients
                          children: [
                            Text('Ingrédients* :', textAlign: TextAlign.start),
                            SizedBox(height: 8),
                            ..._ingredients,
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: const Icon(Icons.add_circle,
                                    color: Colors.green),
                                onPressed: _addIngredient,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),

                  // Ajout d'une image pour la recette
                  Expanded(
                      child: RecipePictureInput(
                          onImageSelected: _handleImageSelected)),
                ],
              ),
              const SizedBox(height: 16),

              // Section Input des étapes de confection avec le bouton d'ajout pour plusieurs étapes
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Étapes* :', textAlign: TextAlign.start),
                  SizedBox(height: 8),
                  ..._steps,
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.add_circle, color: Colors.green),
                      onPressed: _addStep,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (_validationError)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Veuillez remplir tous les champs requis.',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
              const SizedBox(height: 16),

              // Bouton d'ajout de la recette
              ElevatedButton(
                onPressed: _addRecipe,
                child: const Text('Ajouter la recette'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
