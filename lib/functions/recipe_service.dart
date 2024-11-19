import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/recipe_model.dart';

class RecipeService {
  static Future<List<Recipe>> loadDefaultRecipes() async {
    try {
      final String jsonString =
          await rootBundle.loadString('/datas/default_recipes.json');
      final List<dynamic> jsonData = jsonDecode(jsonString);
      return jsonData.map((data) => Recipe.fromJson(data)).toList();
    } catch (e) {
      print('Erreur lors du chargement des recettes par défaut : $e');
      return [];
    }
  }
}
