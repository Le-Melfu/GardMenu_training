import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/recipe_model.dart';
import '../functions/recipe_service.dart';

class RecipeProvider with ChangeNotifier {
  List<Recipe> _recipes = [];

  List<Recipe> get recipes => _recipes;

  RecipeProvider() {
    _loadRecipes();
  }

  Future<void> _saveRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final recipesJson = _recipes.map((recipe) => recipe.toJson()).toList();
    prefs.setString('recipes', jsonEncode(recipesJson));
  }

  Future<void> _loadRecipes() async {
    final prefs = await SharedPreferences.getInstance();
    final String? recipesString = prefs.getString('recipes');

    if (recipesString != null) {
      final List<dynamic> recipesJson = jsonDecode(recipesString);
      _recipes = recipesJson.map((json) => Recipe.fromJson(json)).toList();
    } else {
      final defaultRecipes = await RecipeService.loadDefaultRecipes();
      _recipes = defaultRecipes.cast<Recipe>();
    }

    notifyListeners();
  }

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);
    _saveRecipes();
    notifyListeners();
  }

  void deleteRecipe(Recipe recipe) {
    _recipes.remove(recipe);
    _saveRecipes();
    notifyListeners();
  }
}
