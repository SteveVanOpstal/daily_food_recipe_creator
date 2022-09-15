import 'package:daily_food_recipe_creator/graphql/mutations/update_recipe_mutation.dart';
import 'package:daily_food_recipe_creator/recipes/parts/parts.dart';
import 'package:daily_food_recipe_creator/recipes/recipe/recipe_description_edit.dart';
import 'package:daily_food_recipe_creator/recipes/recipe/recipe_slug_edit.dart';
import 'package:daily_food_recipe_creator/recipes/recipe/recipe_title_edit.dart';
import 'package:flutter/material.dart';

class RecipeWidget extends StatefulWidget {
  RecipeWidget({Key? key, this.recipe}) : super(key: key);

  final dynamic recipe;

  @override
  _RecipeWidgetState createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('recipe'),
      ),
      body: ListView(
        children: [
          TextButton(
            child: Text(widget.recipe['title'] ?? 'Title'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RecipeTitleEditWidget(recipe: widget.recipe);
                },
              );
            },
          ),
          TextButton(
            child: Text(widget.recipe['slug'] ?? 'format-of-the-link'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RecipeSlugEditWidget(recipe: widget.recipe);
                },
              );
            },
          ),
          TextButton(
            child: Text(widget.recipe['description'] ?? 'Description'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RecipeDescriptionEditWidget(recipe: widget.recipe);
                },
              );
            },
          ),
          PartsWidget(parts: widget.recipe['parts'])
        ],
      ),
    );
  }
}
