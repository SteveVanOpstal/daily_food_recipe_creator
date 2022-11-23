import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../main.dart';

class GraphMutationWidget extends StatelessWidget {
  GraphMutationWidget(
      {Key? key, required this.query, required this.builder, this.completed})
      : super(key: key);

  final String query;
  final MutationBuilder builder;
  final VoidCallback? completed;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
        document: gql(query),
        onCompleted: (_) {
          if (completed != null) {
            completed!();
          }
        },
        onError: (exception) {
          final errorSnackbar = SnackBar(
            content: Text('mutation error! "$exception"'),
            duration: Duration(days: 1),
          );

          if (rootScaffoldMessengerKey.currentState != null) {
            rootScaffoldMessengerKey.currentState!.showSnackBar(errorSnackbar);
          }
        },
      ),
      builder: builder,
    );
  }
}
