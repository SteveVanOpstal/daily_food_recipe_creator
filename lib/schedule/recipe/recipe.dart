import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../graphql/graph_query.dart';
import '../../graphql/queries/recipe_query.dart';

class RecipeWidget extends StatefulWidget {
  RecipeWidget({Key? key, this.recipeId}) : super(key: key);

  final String? recipeId;

  @override
  _RecipeWidgetState createState() => _RecipeWidgetState();
}

class _RecipeWidgetState extends State<RecipeWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.recipeId == null) {
      return Text('No recipe');
    }
    return GraphQueryWidget(
      query: recipeQuery,
      variables: {'id': widget.recipeId},
      builder: (
        QueryResult result, {
        Refetch? refetch,
        FetchMore? fetchMore,
      }) {
        if (result.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (result.data == null) {
          return Text('No recipe');
        }
        final recipe = result.data!['queryRecipe'] as List;
        if (recipe.isEmpty) {
          return Text('empty recipe');
        }
        return Text(recipe.first['title']);
      },
    );
  }
}
