import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphMutationWidget extends StatefulWidget {
  GraphMutationWidget({Key? key, this.query, this.builder}) : super(key: key);

  final String? query;
  final MutationBuilder? builder;

  @override
  _GraphMutationWidgetState createState() => _GraphMutationWidgetState();
}

class _GraphMutationWidgetState extends State<GraphMutationWidget> {
  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
          document: gql(widget.query!),
          onError: (exception) {
            final errorSnackbar = SnackBar(
              content: Text('mutation error! "$exception"'),
              duration: Duration(days: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(errorSnackbar);
          }),
      builder: widget.builder!,
    );
  }
}
