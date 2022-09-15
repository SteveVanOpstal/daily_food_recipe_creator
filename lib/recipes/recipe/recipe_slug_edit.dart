import 'package:daily_food_recipe_creator/graphql/mutations/update_recipe_mutation.dart';
import 'package:flutter/material.dart';

import '../../helpers/edit_dialog.dart';

class RecipeSlugEditWidget extends StatefulWidget {
  RecipeSlugEditWidget({Key? key, this.recipe}) : super(key: key);

  final dynamic recipe;

  @override
  _RecipeSlugEditWidgetState createState() => _RecipeSlugEditWidgetState();
}

class _RecipeSlugEditWidgetState extends State<RecipeSlugEditWidget> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _changes = {};

  RegExp _snakeCaseRegex = new RegExp(r'^[a-z]+(?:-[a-z]+)*$');

  @override
  Widget build(BuildContext context) {
    _changes = widget.recipe;
    return EditDialogWidget(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.recipe['slug'],
              onChanged: (value) => _changes['slug'] = value,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'empty';
                }
                return _snakeCaseRegex.hasMatch(value)
                    ? null
                    : 'invalid snake case';
              },
              autofocus: true,
            ),
            UpdateRecipeMutationWidget(
              builder: (updateMutation, result) {
                return ElevatedButton(
                  child: Text('Save'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      updateMutation(_changes);
                      Navigator.pop(context);
                    }
                  },
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
