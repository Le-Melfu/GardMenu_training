import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gardmenu_training/models/recipe_model.dart';
import 'package:gardmenu_training/providers/recipes_provider.dart';
import 'package:provider/provider.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailPage({
    super.key,
    required this.recipe,
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
                Provider.of<RecipeProvider>(context, listen: false)
                    .deleteRecipe(recipe);
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
              Container(
                width: double.infinity,
                color: Color.fromARGB(255, 4, 139, 154),
                child: Image.memory(
                  base64Decode(recipe.image!.split(',').last),
                  fit: BoxFit.contain,
                  height: 220,
                  width: double.infinity,
                ),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Type de proteines : ${recipe.type}"),
                      ],
                    ),
                    //Ingrédients
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ingredients:',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 8),
                          ...recipe.ingredients.map((ingredient) => Text(
                              '- ${ingredient.name} ${ingredient.quantity > 0 ? ingredient.quantity : ''} ${ingredient.measureUnit.isNotEmpty ? ingredient.measureUnit : ''}')),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Etapes
                    SizedBox(
                      width: double.infinity,
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
                  ],
                ),
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
