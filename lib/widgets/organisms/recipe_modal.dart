import 'package:flutter/material.dart';
import '../atoms/recipe_ingredient_input.dart';
import '../atoms/recipe_steps_input.dart';
import '../atoms/recipe_image_input.dart';
import '../../models/recipe_model.dart';

class RecipeModal extends StatefulWidget {
  final Function(Recipe) onAddRecipe;

  const RecipeModal({super.key, required this.onAddRecipe});

  @override
  State<RecipeModal> createState() => _RecipeModalState();
}

class _RecipeModalState extends State<RecipeModal> {
  final TextEditingController _nameController = TextEditingController();
  final List<RecipeIngredientInput> _ingredients = [RecipeIngredientInput()];
  final List<RecipeStepInput> _steps = [RecipeStepInput(stepNumber: 1)];
  String? _imageBase64;

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

  // Méthode d'ajout d'une recette avec construction de la nouvelle recette
  void _addRecipe() {
    final recipe = Recipe(
      name: _nameController.text,
      ingredients: _ingredients.map((input) => input.ingredient).toList(),
      steps: _steps.map((input) => input.controller.text).toList(),
      image: _imageBase64,
    );

    widget.onAddRecipe(recipe); //Ajout de la nouvelle recette à la liste
    Navigator.of(context).pop(); //Sortie de la modale
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
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // Input du nom de la recette
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nom du plat',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Section Ingredients
                        Column(
                          // Input des ingrédients avec le bouton d'ajout pour plusieurs ingrédients
                          children: [
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
                children: [
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
