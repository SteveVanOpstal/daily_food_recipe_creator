import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQueryWidget extends StatefulWidget {
  GraphQueryWidget(
      {Key? key, this.query, this.builder, this.variables = const {}})
      : super(key: key);

  final String? query;
  final Map<String, dynamic> variables;
  final QueryBuilder? builder;

  @override
  _GraphQueryWidgetState createState() => _GraphQueryWidgetState();
}

class _GraphQueryWidgetState extends State<GraphQueryWidget> {
  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: gql(widget.query!),
          variables: widget.variables,
          fetchPolicy: FetchPolicy.networkOnly,
          // pollInterval: const Duration(seconds: 3),
        ),
        builder: (
          QueryResult result, {
          Refetch? refetch,
          FetchMore? fetchMore,
        }) {
          if (result.hasException) {
            final exception = result.exception.toString();
            final errorSnackbar = SnackBar(
              content: Text('query error! "$exception"'),
              duration: Duration(days: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(errorSnackbar);
            return Center(child: Text('an error occured fetching the query'));
          }

          return widget.builder!(
            result,
            refetch: refetch,
            fetchMore: fetchMore,
          );
        });
  }
}
