import 'package:flutter/material.dart';

class RecipeStepInput extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final int stepNumber;

  RecipeStepInput({super.key, required this.stepNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Étape $stepNumber'),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
