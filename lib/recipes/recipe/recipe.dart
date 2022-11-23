import 'package:daily_food_recipe_creator/helpers/primary_text_button.dart';
import 'package:daily_food_recipe_creator/recipes/parts/parts.dart';
import 'package:daily_food_recipe_creator/recipes/recipe/recipe_description_edit.dart';
import 'package:daily_food_recipe_creator/recipes/recipe/recipe_slug_edit.dart';
import 'package:daily_food_recipe_creator/recipes/recipe/recipe_title_edit.dart';
import 'package:flutter/material.dart';

import '../../helpers/secondary_text_button.dart';

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
          PrimaryTextButton(
            child: Text(widget.recipe['title'] ?? 'Title'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RecipeTitleEditWidget(
                    recipe: widget.recipe,
                    changed: () {
                      setState(() {});
                    },
                  );
                },
              );
            },
          ),
          PrimaryTextButton(
            child: Text(widget.recipe['slug'] ?? 'format-of-the-link'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RecipeSlugEditWidget(
                    recipe: widget.recipe,
                    changed: () {
                      setState(() {});
                    },
                  );
                },
              );
            },
          ),
          SecondaryTextButton(
            child: Text(widget.recipe['description'] ?? 'Description'),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return RecipeDescriptionEditWidget(
                    recipe: widget.recipe,
                    changed: () {
                      setState(() {});
                    },
                  );
                },
              );
            },
          ),
          PartsWidget(recipe: widget.recipe)
        ],
      ),
    );
  }
}
