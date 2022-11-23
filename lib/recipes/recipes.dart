import 'package:daily_food_recipe_creator/recipes/recipe/recipe.dart';
import 'package:flutter/material.dart';

import '../graphql/graph_mutation.dart';
import '../graphql/mutations/add_recipe_mutation.dart';

class RecipesWidget extends StatefulWidget {
  RecipesWidget({Key? key, this.recipes}) : super(key: key);

  final List<dynamic>? recipes;

  @override
  _RecipesWidgetState createState() => _RecipesWidgetState();
}

class _RecipesWidgetState extends State<RecipesWidget> {
  buildRecipeButton(dynamic recipe) {
    return Column(children: [
      Text(
        recipe['title'],
        style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
      ),
      Text(recipe['description'] ?? '')
    ]);
  }

  buildRecipes(List<dynamic> recipes) {
    var recipeWidgets = [];
    for (var recipe in recipes) {
      recipeWidgets.add(ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
              return RecipeWidget(recipe: recipe);
            }));
          },
          child: buildRecipeButton(recipe)));
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
      ...buildRecipes(widget.recipes!),
      GraphMutationWidget(
        query: addRecipeMutation,
        builder: (addMutation, result) {
          return IconButton(
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
            ),
            icon: Icon(Icons.add),
            onPressed: () {
              addMutation({
                'title': 'New recipe',
                'slug': 'new-recipe',
              });
            },
          );
        },
      ),
    ]);
  }
}
