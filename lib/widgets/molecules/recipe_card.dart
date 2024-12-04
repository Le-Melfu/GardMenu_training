import 'package:flutter/material.dart';
import 'package:gardmenu_training/functions/build_image.dart';
import 'package:gardmenu_training/models/recipe_model.dart';
import 'package:gardmenu_training/pages/page_recipe_detail.dart';

class RecipeCardWidget extends StatelessWidget {
  final Recipe recipe;

  const RecipeCardWidget({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RecipeDetailPage(recipe: recipe),
            ),
          );
        },
        child: Card(
          color: Color.fromARGB(255, 255, 146, 106),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image de la recette (si disponible)

              if (recipe.image != null && recipe.image!.isNotEmpty)
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    ),
                    child: BuildImage(base64Image: recipe.image!),
                  ),
                ),
              const SizedBox(height: 8),
              // Titre de la recette
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16, left: 8, right: 8),
                  child: Column(
                    children: [
                      Text(
                        recipe.name,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        ),
                        textWidthBasis: TextWidthBasis.longestLine,
                      ),
                      Text(recipe.type,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontFamily: 'Roboto',
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
