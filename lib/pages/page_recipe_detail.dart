import 'dart:convert';

import 'package:flutter/material.dart';
import '../widgets/atoms/recipe_model.dart'; // Import your Recipe model

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailPage(this.recipe, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the image if available
            if (recipe.image != null)
              Image.memory(
                base64Decode(recipe.image!.split(',').last),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),

            const SizedBox(height: 16),

            // Display the ingredients
            Text(
              'Ingredients:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ...recipe.ingredients.map((ingredient) => Text('- $ingredient')),

            const SizedBox(height: 16),

            // Display the steps
            Text(
              'Steps:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ...recipe.steps.asMap().entries.map((entry) {
              final stepNumber = entry.key + 1;
              final step = entry.value;
              return Text('$stepNumber. $step');
            }),
          ],
        ),
      ),
    );
  }
}