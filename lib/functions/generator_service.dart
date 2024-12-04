import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gardmenu_training/models/recipe_model.dart';

class ProteinTypeSelector extends StatefulWidget {
  final Function(Map<String, int>) onPointsAllocated;

  const ProteinTypeSelector({super.key, required this.onPointsAllocated});

  @override
  _ProteinTypeSelectorState createState() => _ProteinTypeSelectorState();
}

class _ProteinTypeSelectorState extends State<ProteinTypeSelector> {
  final Map<String, int> _points = {
    'Végétal': 0,
    'Volaille': 0,
    'Viande Rouge': 0,
    'Gibier': 0,
    'Porc': 0,
    'Poisson/Produit de la mer': 0,
    'Oeufs': 0,
    'Produits laitiers': 0,
  };

  int _remainingPoints = 14;

  void _updatePoints(String type, int change) {
    setState(() {
      int newCount = _points[type]! + change;

      if (newCount >= 0 && _remainingPoints - change >= 0) {
        _points[type] = newCount;
        _remainingPoints -= change;
      }
    });
    widget.onPointsAllocated(_points);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Points restants : $_remainingPoints'),
        Column(
          children: _points.keys.map((type) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(type),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () => _updatePoints(type, -1),
                    ),
                    Text('${_points[type]}'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => _updatePoints(type, 1),
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

Map<String, Recipe> generateWeeklyMenu(
    List<Recipe> allRecipes, Map<String, int> pointsAllocation) {
  Map<String, List<Recipe>> categorizedRecipes = {
    for (var type in pointsAllocation.keys) type: []
  };

  for (Recipe recipe in allRecipes) {
    if (categorizedRecipes.containsKey(recipe.type)) {
      categorizedRecipes[recipe.type]?.add(recipe);
    }
  }

  Random random = Random();
  Map<String, Recipe> weeklyMenu = {};
  int dayCounter = 1;

  pointsAllocation.forEach((type, count) {
    for (int i = 0; i < count; i++) {
      List<Recipe> recipesOfType = categorizedRecipes[type] ?? [];
      if (recipesOfType.isNotEmpty) {
        Recipe selectedRecipe =
            recipesOfType[random.nextInt(recipesOfType.length)];
        weeklyMenu['$dayCounter'] = selectedRecipe;
        dayCounter++;
      }
    }
  });

  return weeklyMenu;
}
