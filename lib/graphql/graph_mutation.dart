import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphMutationWidget extends StatelessWidget {
  GraphMutationWidget({Key? key, required this.query, required this.builder})
      : super(key: key);

  final String query;
  final MutationBuilder builder;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql(query),
        onError: (exception) {
          final errorSnackbar = SnackBar(
            content: Text('mutation error! "$exception"'),
            duration: Duration(days: 1),
          );
          ScaffoldMessenger.of(context).showSnackBar(errorSnackbar);
        },
      ),
      builder: builder,
    );
  }
}
