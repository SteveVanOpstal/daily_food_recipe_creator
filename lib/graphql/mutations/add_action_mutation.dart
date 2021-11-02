import 'package:daily_food_recipe_creator/graphql/graph_mutation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddActionMutationWidget extends StatelessWidget {
  AddActionMutationWidget({Key? key, this.builder}) : super(key: key);

  final MutationBuilder? builder;

  @override
  Widget build(BuildContext context) {
    return GraphMutationWidget(
      query: r'''
        mutation {
          addAction(input: [{description: ""}]) {
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
