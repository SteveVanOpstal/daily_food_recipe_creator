import 'package:daily_food_recipe_creator/recipes/recipe.dart';
import 'package:flutter/material.dart';

class RecipesWidget extends StatefulWidget {
  RecipesWidget({Key? key, this.recipes}) : super(key: key);

  final List<dynamic>? recipes;

  @override
  _RecipesWidgetState createState() => _RecipesWidgetState();
}

class _RecipesWidgetState extends State<RecipesWidget> {
  createRecipeButton(dynamic recipe) {
    return Column(children: [
      Text(recipe['title']),
      Text(recipe['slug']),
      Text(recipe['description'])
    ]);
  }

  createRecipes(List<dynamic> recipes) {
    var recipeWidgets = [];
    for (var recipe in recipes) {
      recipeWidgets.add(ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
              return RecipeWidget(recipe: recipe);
            }));
          },
          child: createRecipeButton(recipe)));
    }
    return recipeWidgets;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.recipes == null) {
      return Center(
        child: Text('no recipes'),
      );
    }
    return GridView.count(crossAxisCount: 5, children: [
      ...createRecipes(widget.recipes!),
    ]);
  }
}
