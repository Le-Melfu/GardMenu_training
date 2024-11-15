import 'package:flutter/material.dart';
import 'package:gardmenu_training/functions/build_image.dart';
import 'package:gardmenu_training/pages/page_recipe_detail.dart';
import 'package:gardmenu_training/models/recipe_model.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailPage(recipe),
              ),
            );
          },
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image de la recette (si disponible)

                if (recipe.image != null && recipe.image!.isNotEmpty)
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: BuildImage(base64Image: recipe.image!),
                    ),
                  ),
                const SizedBox(height: 8),
                // Titre de la recette
                Padding(
                  padding: const EdgeInsets.only(
                      left: 22.0, bottom: 8.0, right: 8.0, top: 8.0),
                  child: Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
