import 'package:daily_food_recipe_creator/graphql/mutations/update_measurement_mutation.dart';
import 'package:daily_food_recipe_creator/graphql/mutations/update_recipe_mutation.dart';
import 'package:daily_food_recipe_creator/recipes/parts/parts.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RecipeWidget extends StatefulWidget {
  RecipeWidget({Key? key, this.recipe}) : super(key: key);

  final dynamic recipe;

  @override
  _RecipeWidgetState createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _changes = {};

  RegExp _snakeCaseRegex = new RegExp(r'^[a-z]+(?:-[a-z]+)*$');

  @override
  Widget build(BuildContext context) {
    _changes = widget.recipe;
    return Scaffold(
      appBar: AppBar(
        title: Text('recipe'),
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: widget.recipe['title'],
                  onChanged: (value) => _changes['title'] = value,
                  validator: (value) => value!.isEmpty ? 'empty' : null,
                ),
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
                ),
                TextFormField(
                  initialValue: widget.recipe['description'],
                  onChanged: (value) => _changes['description'] = value,
                  validator: (value) => value!.isEmpty ? 'empty' : null,
                ),
                UpdateRecipeMutationWidget(
                  builder: (updateMutation, result) {
                    return ElevatedButton(
                      child: Text('submit'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          updateMutation(_changes);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          PartsWidget(parts: widget.recipe['parts'])
        ],
      ),
    );
  }
}
