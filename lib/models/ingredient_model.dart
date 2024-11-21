class Ingredient {
  final String name;
  final double quantity;
  final String measureUnit;

  Ingredient({
    required this.name,
    required this.quantity,
    required this.measureUnit,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'measureUnit': measureUnit,
    };
  }

  factory Ingredient.fromMap(Map<String, dynamic> map) {
    return Ingredient(
      name: map['name'],
      quantity: map['quantity'] != null && map['quantity'] != ''
          ? double.tryParse(map['quantity'].toString()) ?? 0.0
          : 0.0,
      measureUnit: map['measureUnit'] ?? '',
    );
  }
}
