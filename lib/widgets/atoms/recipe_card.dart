import 'package:flutter/material.dart';
import '../../functions/buildImage.dart';
import '../atoms/recipe_model.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image de la recette (si disponible)
                if (recipe.image != null)
                  if (recipe.image != null && recipe.image!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BuildImage(base64Image: recipe.image!),
                    ),
                const SizedBox(height: 8),
                // Titre de la recette
                Text(
                  recipe.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),



                // Ingrédients
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Ingrédients :', style: TextStyle(fontWeight: FontWeight.bold)),
                    ...recipe.ingredients.map((e) => Text(e)).toList(),
                  ],
                ),
                const SizedBox(height: 8),

                // Étapes
                Text(
                  'Étapes : ${recipe.steps.length} étape(s)',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
