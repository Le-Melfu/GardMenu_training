import 'package:flutter/material.dart';
import 'package:gardmenu_training/models/recipe_model.dart';
import 'package:gardmenu_training/providers/recipes_provider.dart';
import 'package:gardmenu_training/widgets/molecules/recipe_card.dart';
import 'package:gardmenu_training/widgets/organisms/generator_modal.dart';
import 'package:provider/provider.dart';

class PageMenuGenerator extends StatelessWidget {
  const PageMenuGenerator({super.key});

  @override
  Widget build(BuildContext context) {
    final recipes = Provider.of<RecipeProvider>(context).recipes;
    final generatedMenu = Provider.of<RecipeProvider>(context).generatedMenu;

    void _openGeneratorModal(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return MenuGeneratorModal(
            allRecipes: recipes,
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Générateur de menu'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => _openGeneratorModal(context),
              child: const Text('Génerer un nouveau Menu'),
            ),
          ),
          if (generatedMenu.isNotEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Nombre de colonnes dans la grille
                    crossAxisSpacing: 30, // Espacement entre les colonnes
                    mainAxisSpacing: 30, // Espacement entre les lignes
                  ),
                  itemCount: generatedMenu.length,
                  itemBuilder: (context, index) {
                    // Obtenez le type de protéine (clé) et la recette (valeur) depuis le Map
                    String proteinType = generatedMenu.keys.elementAt(index);
                    Recipe recipe = generatedMenu[proteinType]!;

                    // Affichez chaque recette avec votre carte personnalisée
                    return RecipeCardWidget(
                      recipe:
                          recipe, // Assurez-vous que RecipeCard prend un objet Recipe
                      // Si nécessaire, vous pouvez aussi transmettre le type de protéine
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
