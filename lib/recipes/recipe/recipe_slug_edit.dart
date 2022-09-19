import 'package:daily_food_recipe_creator/graphql/mutations/update_recipe_mutation.dart';
import 'package:flutter/material.dart';

import '../../graphql/mutation_dialog.dart';

class RecipeSlugEditWidget extends MutationDialogWidget {
  RecipeSlugEditWidget({Key? key, this.recipe, required this.changed})
      : super(
            key: key,
            changed: changed,
            query: updateRecipeMutation,
            subject: recipe,
            subjectKey: 'slug',
            validator: (value) {
              if (value!.isEmpty) {
                return 'empty';
              }
              return new RegExp(r'^[a-z]+(?:-[a-z]+)*$').hasMatch(value)
                  ? null
                  : 'invalid snake case';
            });

  final dynamic recipe;
  final Function changed;
}
