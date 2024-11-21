import 'package:gardmenu_training/models/ingredient_model.dart';

class Recipe {
  final String name;
  final List<Ingredient> ingredients;
  final List<String> steps;
  final String? image;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.steps,
    this.image,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      ingredients: List<Ingredient>.from(json['ingredients']
          .map((ingredient) => Ingredient.fromMap(ingredient))),
      steps: List<String>.from(json['steps']),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ingredients':
          ingredients.map((ingredient) => ingredient.toMap()).toList(),
      'steps': steps,
      'image': image,
    };
  }
}
