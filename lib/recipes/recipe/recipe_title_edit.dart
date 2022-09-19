import 'package:daily_food_recipe_creator/graphql/mutations/update_recipe_mutation.dart';
import 'package:flutter/material.dart';

import '../../graphql/mutation_dialog.dart';

class RecipeTitleEditWidget extends MutationDialogWidget {
  RecipeTitleEditWidget({Key? key, this.recipe, required this.changed})
      : super(
            key: key,
            changed: changed,
            query: updateRecipeMutation,
            subject: recipe,
            subjectKey: 'title',
            validator: (value) => value!.isEmpty ? 'empty' : null);

  final dynamic recipe;
  final Function changed;
}
