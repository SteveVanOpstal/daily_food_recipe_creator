import 'package:daily_food_recipe_creator/graphql/graph_mutation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UpdateActionMutationWidget extends StatelessWidget {
  UpdateActionMutationWidget({Key? key, this.builder}) : super(key: key);

  final MutationBuilder? builder;

  @override
  Widget build(BuildContext context) {
    return GraphMutationWidget(
      query: r'''
        mutation ($id: ID!, $description: String, $icon: String) {
          updateAction(input: {
                      filter: {id: [$id]},
                      set: {
                        description: $description
                        icon: $icon
                      }
                    }) {
            action {
              id
            }
          }
        }
      ''',
      builder: this.builder!,
    );
  }
}
