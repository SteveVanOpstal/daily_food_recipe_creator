import 'package:daily_food_recipe_creator/graphql/queries/action_query.dart';
import 'package:daily_food_recipe_creator/recipes/actions/action_edit.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ActionsViewWidget extends StatefulWidget {
  ActionsViewWidget(
      {Key? key,
      required this.parent,
      required this.actionIds,
      this.inverse = false})
      : super(key: key);

  final dynamic parent;
  final List<dynamic> actionIds;
  final bool inverse;

  @override
  _ActionsViewWidgetState createState() => _ActionsViewWidgetState();
}

class _ActionsViewWidgetState extends State<ActionsViewWidget> {
  buildActions(List<dynamic> actions, Refetch? refetch) {
    return actions
        .map((action) => ActionEditWidget(
                  parent: widget.parent,
                  action: action,
                  refetch: refetch,
                )

            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //       backgroundColor: widget.inverse
            //           ? Colors.white
            //           : Theme.of(context).primaryColor,
            //       foregroundColor: widget.inverse
            //           ? Theme.of(context).primaryColor
            //           : Colors.white),
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
            //         return ;
            //       }),
            //     );
            //   },
            //   child: ActionViewWidget(
            //     action: action,
            //     inverse: widget.inverse,
            //   ),
            // ),
            )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.actionIds == null) {
    //   return Center(
    //     child: Text('no actions'),
    //   );
    // }
    return ActionQueryWidget(
      ids: widget.actionIds,
      builder: (
        QueryResult result, {
        Refetch? refetch,
        FetchMore? fetchMore,
      }) {
        return result.isLoading || result.data == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...buildActions(result.data!['queryAction'], refetch)
                ],
              );
      },
    );
  }
}
