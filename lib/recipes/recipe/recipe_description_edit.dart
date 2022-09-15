import 'package:daily_food_recipe_creator/graphql/mutations/update_recipe_mutation.dart';
import 'package:flutter/material.dart';

import '../../helpers/edit_dialog.dart';

class RecipeDescriptionEditWidget extends StatefulWidget {
  RecipeDescriptionEditWidget({Key? key, this.recipe}) : super(key: key);

  final dynamic recipe;

  @override
  _RecipeDescriptionEditWidgetState createState() =>
      _RecipeDescriptionEditWidgetState();
}

class _RecipeDescriptionEditWidgetState
    extends State<RecipeDescriptionEditWidget> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _changes = {};

  @override
  Widget build(BuildContext context) {
    _changes = widget.recipe;
    return EditDialogWidget(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: widget.recipe['description'],
              onChanged: (value) => _changes['description'] = value,
              validator: (value) => value!.isEmpty ? 'empty' : null,
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
