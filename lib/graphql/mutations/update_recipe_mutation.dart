import 'package:daily_food_recipe_creator/graphql/graph_mutation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UpdateRecipeMutationWidget extends StatelessWidget {
  UpdateRecipeMutationWidget({Key? key, this.builder}) : super(key: key);

  final MutationBuilder? builder;

  @override
  Widget build(BuildContext context) {
    return GraphMutationWidget(
      query: r'''
        mutation ($id: ID!, $title: String, $slug: String, $description: String) {
          updateRecipe(input: {
                        filter: {id: [$id]},
                        set: {
                          title: $title
                          slug: $slug
                          description: $description
                        }
                      }) {
            recipe {
              id
              title
              slug
              description
            }
          }
        }
      ''',
      builder: this.builder!,
    );
  }
}
