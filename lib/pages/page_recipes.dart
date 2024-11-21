import 'package:flutter/material.dart';
import 'package:gardmenu_training/providers/recipes_provider.dart';
import 'package:provider/provider.dart';
import '../widgets/organisms/recipe_modal.dart';
import '../widgets/molecules/recipe_card.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  void _openRecipeModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RecipeModal();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<RecipeProvider>(context).recipes;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Recettes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => _openRecipeModal(context),
              child: const Text('Ajouter une recette'),
            ),
          ),
          Expanded(
            child: recipes.isEmpty
                ? const Center(child: Text('Aucune recette ajoutée.'))
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      itemCount: recipes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        return RecipeCardWidget(recipe: recipes[index]);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
