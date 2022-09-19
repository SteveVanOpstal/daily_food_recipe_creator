import 'package:daily_food_recipe_creator/graphql/mutations/update_recipe_mutation.dart';
import 'package:flutter/material.dart';

import '../../graphql/mutation_dialog.dart';

class RecipeDescriptionEditWidget extends MutationDialogWidget {
  RecipeDescriptionEditWidget({Key? key, this.recipe, required this.changed})
      : super(
            key: key,
            changed: changed,
            query: updateRecipeMutation,
            subject: recipe,
            subjectKey: 'description',
            validator: (value) => value!.isEmpty ? 'empty' : null);

  final dynamic recipe;
  final Function changed;
}
