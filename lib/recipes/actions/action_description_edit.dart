import 'package:daily_food_recipe_creator/graphql/mutations/update_action_mutation.dart';
import 'package:flutter/material.dart';

import '../../graphql/mutation_dialog.dart';

class ActionDescriptionEditWidget extends MutationDialogWidget {
  ActionDescriptionEditWidget({Key? key, this.action, required this.changed})
      : super(
            key: key,
            changed: changed,
            query: updateActionMutation,
            subject: action,
            subjectKey: 'description',
            validator: (value) => value!.isEmpty ? 'empty' : null);

  final dynamic action;
  final Function changed;
}
