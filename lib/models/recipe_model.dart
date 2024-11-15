
class Recipe {
  final String name;
  final List<String> ingredients;
  final List<String> steps;
  final String? image;

  Recipe({
    required this.name,
    required this.ingredients,
    required this.steps,
    this.image,
  });

  // Convertir un objet Recipe en JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ingredients': ingredients,
      'steps': steps,
      'image': image,
    };
  }

  // Convertir un JSON en objet Recipe
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
      image: json['image'],
    );
  }
}
