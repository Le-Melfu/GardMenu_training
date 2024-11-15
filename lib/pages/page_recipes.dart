import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gardmenu_training/widgets/atoms/recipe_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/atoms/recipe_model.dart'; // Import the Recipe model
import '../widgets/molecules/recipe_modal.dart'; // Import the RecipeModal widget

class RecipePage extends StatefulWidget {
  const RecipePage({super.key});

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  List<Recipe> _recipes = []; // List to hold all recipes
  @override
  void initState() {
    super.initState();
    _loadRecipes(); // Charger les recettes au démarrage de l'appli
  }

  // Fonction pour sauvegarder les recettes
  Future<void> _saveRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final recipesJson = _recipes.map((recipe) => recipe.toJson()).toList();
    prefs.setString('recipes', jsonEncode(recipesJson));
  }

  // Fonction pour charger les recettes
  Future<void> _loadRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? recipesString = prefs.getString('recipes');
    if (recipesString != null) {
      final List<dynamic> recipesJson = jsonDecode(recipesString);
      setState(() {
        _recipes = recipesJson.map((json) => Recipe.fromJson(json)).toList();
      });
    }
  }

  // Function to add a recipe
  void _addRecipe(Recipe recipe) {
    setState(() {
      _recipes.add(recipe);
    });
    _saveRecipes();
  }

  // Function to open the modal
  void _openRecipeModal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RecipeModal(
            onAddRecipe:
                _addRecipe); // Pass the _addRecipe function to the modal
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Recettes'),
      ),
      body: Column(
        children: [
          // Button above the list
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _openRecipeModal,
              // Open the modal when the button is pressed
              child: const Text('Ajouter une recette'),
            ),
          ),
          // List of recipes
          Expanded(
            child: _recipes.isEmpty
                ? const Center(child: Text('Aucune recette ajoutée.'))
                : Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GridView.builder(
                      itemCount: _recipes.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // Nombre de colonnes
                        crossAxisSpacing: 16.0, // Espacement horizontal
                        mainAxisSpacing: 16.0, // Espacement vertical
                        childAspectRatio: 1, // Ratio largeur/hauteur
                      ),
                      itemBuilder: (context, index) {
                        return RecipeCard(recipe: _recipes[index]);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
