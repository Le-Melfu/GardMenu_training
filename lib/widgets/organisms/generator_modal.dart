import 'package:flutter/material.dart';
import 'package:gardmenu_training/functions/generator_service.dart';
import 'package:gardmenu_training/models/recipe_model.dart';
import 'package:gardmenu_training/providers/recipes_provider.dart';
import 'package:provider/provider.dart';

class MenuGeneratorModal extends StatefulWidget {
  final List<Recipe> allRecipes;

  const MenuGeneratorModal({super.key, required this.allRecipes});

  @override
  _MenuGeneratorModalState createState() => _MenuGeneratorModalState();
}

class _MenuGeneratorModalState extends State<MenuGeneratorModal> {
  Map<String, int> _selectedPoints = {};

  void _generateMenu() {
    // Compléter les points restants avec "Végétal"
    int totalPoints =
        _selectedPoints.values.fold(0, (sum, points) => sum + points);
    int remainingPoints = 14 - totalPoints;

    if (remainingPoints > 0) {
      _selectedPoints.update('Végétal', (value) => value + remainingPoints,
          ifAbsent: () => remainingPoints);
    }

    // Appeler la fonction de génération avec les points attribués
    Map<String, Recipe> weeklyMenu =
        generateWeeklyMenu(widget.allRecipes, _selectedPoints);
    Provider.of<RecipeProvider>(context, listen: false)
        .setGeneratedMenu(weeklyMenu);
    // Afficher le menu
    print(weeklyMenu);
    Navigator.of(context).pop(); // Fermer la modale
    // Afficher ou traiter le menu généré
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ProteinTypeSelector(
              onPointsAllocated: (points) {
                _selectedPoints = points;
              },
            ),
            ElevatedButton(
              onPressed: _generateMenu,
              child: const Text('Générer le menu'),
            ),
          ],
        ),
      ),
    );
  }
}
