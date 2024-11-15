import 'package:flutter/material.dart';
import '../atoms/recipe_ingredient_input.dart';
import '../atoms/recipe_steps_input.dart';
import '../atoms/recipe_image_input.dart';
import '../atoms/recipe_model.dart'; // Import the Recipe class

class RecipeModal extends StatefulWidget {
  final Function(Recipe) onAddRecipe; // Callback function to add a recipe

  const RecipeModal({super.key, required this.onAddRecipe});

  @override
  State<RecipeModal> createState() => _RecipeModalState();
}

class _RecipeModalState extends State<RecipeModal> {
  final TextEditingController _nameController = TextEditingController();
  final List<RecipeIngredientInput> _ingredients = [RecipeIngredientInput()];
  final List<RecipeStepInput> _steps = [RecipeStepInput(stepNumber: 1)];
  String? _imageBase64; // This will hold the base64 image data

  void _handleImageSelected(String? base64Image) {
    setState(() {
      _imageBase64 = base64Image;
    });
  }

  // Method to add an ingredient
  void _addIngredient() {
    setState(() {
      _ingredients.add(RecipeIngredientInput());
    });
  }

  // Method to add a step
  void _addStep() {
    setState(() {
      _steps.add(RecipeStepInput(stepNumber: _steps.length + 1));
    });
  }

  // Method to handle adding the recipe
  void _addRecipe() {
    final recipe = Recipe(
      name: _nameController.text,
      ingredients: _ingredients.map((input) => input.ingredient).toList(),
      steps: _steps.map((input) => input.controller.text).toList(),
      image: _imageBase64,
    );

    debugPrint('Recipe Modal Recipe Creation Data:');
    debugPrint('  Name: ${recipe.name}');
    debugPrint('  Ingredients: ${recipe.ingredients}');
    debugPrint('  Steps: ${recipe.steps}');
    debugPrint(
        '  Image (Base64): ${recipe.image != null ? 'Data present' : 'Null'}');

    widget.onAddRecipe(recipe);
    Navigator.of(context).pop();
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
              // Name input
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nom du plat',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Ingredients section
                        Column(
                          children: [
                            ..._ingredients, // List of ingredient inputs
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
                  Expanded(
                      child: RecipePictureInput(
                          onImageSelected: _handleImageSelected)),
                ],
              ),
              const SizedBox(height: 16),

              // Steps section
              Column(
                children: [
                  ..._steps, // List of step inputs
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

              // Add Recipe Button
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
