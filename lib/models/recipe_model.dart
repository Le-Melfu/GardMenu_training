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

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'],
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['steps']),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'ingredients': ingredients,
      'steps': steps,
      'image': image,
    };
  }
}
