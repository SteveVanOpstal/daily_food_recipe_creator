import 'package:daily_food_recipe_creator/recipes/recipe/recipe.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../graphql/graph_mutation.dart';
import '../graphql/graph_query.dart';
import '../graphql/mutations/add_recipe_mutation.dart';
import '../graphql/queries/recipes_query.dart';

class RecipesWidget extends StatefulWidget {
  RecipesWidget({Key? key}) : super(key: key);

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

  buildRecipeAddButton() {
    return GraphMutationWidget(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
      body: GraphQueryWidget(
        query: recipesQuery,
        builder: (
          QueryResult result, {
          Refetch? refetch,
          FetchMore? fetchMore,
        }) {
          if (result.isLoading || result.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final recipes = result.data!['queryRecipe'];
          if (recipes == null) {
            return buildRecipeAddButton();
          }
          return GridView.count(
            crossAxisCount: 5,
            children: [
              ...buildRecipes(recipes!),
              buildRecipeAddButton(),
            ],
          );
        },
      ),
    );
  }
}
