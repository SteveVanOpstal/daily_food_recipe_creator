import 'package:daily_food_recipe_creator/graphql/graph_query.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ActionQueryWidget extends StatelessWidget {
  ActionQueryWidget({Key? key, this.ids, this.builder}) : super(key: key);

  final List<dynamic>? ids;
  final QueryBuilder? builder;

  @override
  Widget build(BuildContext context) {
    return GraphQueryWidget(
      query: r'''
        query ($ids: [ID!]) {
          queryAction(filter: {id: $ids}){
            id
            description
            icon
            measurement {
              id
              amount
              unit {
                abbr
                singular
                plural
                relative
              }
              product {
                name
                plural
                basic
              }
            }
            actions {
              id
            }
          }
        }
      ''',
      variables: {'ids': this.ids!},
      builder: this.builder!,
    );
  }
}
