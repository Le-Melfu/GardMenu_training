import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gardmenu_training/pages/page_recipes.dart';
import '../models/recipe_model.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onDelete;

  const RecipeDetailPage({
    super.key,
    required this.recipe,
    required this.onDelete,
  });

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content:
              const Text('Êtes-vous sûr de vouloir supprimer cette recette ?'),
          actions: [
            TextButton(
              onPressed: () {
                onDelete();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Supprimer'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Annuler'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            //Image de la recette
            if (recipe.image != null)
              Image.memory(
                base64Decode(recipe.image!.split(',').last),
                fit: BoxFit.cover,
                height: 220,
                width: double.infinity,
              ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Etapes
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Étapes :',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        ...recipe.steps.asMap().entries.map((entry) {
                          final stepNumber = entry.key + 1;
                          final step = entry.value;
                          return Text(
                            '$stepNumber. $step',
                            maxLines: 2,
                          );
                        }),
                      ],
                    ),
                  ),

                  //Ingrédients
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ingredients:',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        ...recipe.ingredients
                            .map((ingredient) => Text('- $ingredient')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            IconButton(
                onPressed: () => _confirmDelete(context),
                icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
