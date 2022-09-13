import 'package:daily_food_recipe_creator/graphql/graph_mutation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UpdatePartMutationWidget extends StatelessWidget {
  UpdatePartMutationWidget({Key? key, this.builder}) : super(key: key);

  final MutationBuilder? builder;

  @override
  Widget build(BuildContext context) {
    return GraphMutationWidget(
      query: r'''
        mutation ($id: ID!, $title: String, $actions: [Action]) {
          updatePart(input: {
                      filter: {id: [$id]},
                      set: {
                        title: $title
                        actions: $actions
                      }
                    }) {
            part {
              id
            }
          }
        }
      ''',
      builder: this.builder!,
    );
  }
}
