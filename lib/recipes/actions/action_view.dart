import 'package:daily_food_recipe_creator/graphql/queries/action_query.dart';
import 'package:daily_food_recipe_creator/recipes/actions/actions_view.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:food_icons/food_icons.dart';

class ActionViewWidget extends StatefulWidget {
  ActionViewWidget({Key? key, this.action, this.inverse = false})
      : super(key: key);

  final dynamic action;
  final bool inverse;

  @override
  _ActionViewWidgetState createState() => _ActionViewWidgetState();
}

class _ActionViewWidgetState extends State<ActionViewWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      Row(
        children: [
          Icon(widget.action['icon'] == null
              ? Icons.error
              : FoodIcons.getIcon(widget.action['icon'])),
          Text(widget.action['description']),
        ],
      ),
    ];
    var actions = widget.action['actions'] as List<dynamic>;
    if (actions.isNotEmpty) {
      var actionIds = actions.map((a) => a['id']).toList();

      children.add(
        Container(
          child: ActionQueryWidget(
              ids: actionIds,
              builder: (
                QueryResult result, {
                Refetch? refetch,
                FetchMore? fetchMore,
              }) {
                return result.isLoading || result.data == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ActionsViewWidget(
                        actions: result.data!['queryAction'],
                        inverse: !widget.inverse,
                      );
              }),
        ),
      );
    }

    return Column(
      children: children,
    );
  }
}
