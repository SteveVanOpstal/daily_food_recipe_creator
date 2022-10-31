import 'package:daily_food_recipe_creator/graphql/graph_mutation.dart';
import 'package:daily_food_recipe_creator/graphql/mutations/add_action_mutation.dart';
import 'package:daily_food_recipe_creator/recipes/actions/actions_view.dart';
import 'package:flutter/material.dart';

class ActionsEditWidget extends StatefulWidget {
  ActionsEditWidget({Key? key, this.actions}) : super(key: key);

  final List<dynamic>? actions;

  @override
  _ActionsEditWidgetState createState() => _ActionsEditWidgetState();
}

class _ActionsEditWidgetState extends State<ActionsEditWidget> {
  createActionsView() {
    var components = [];
    if (widget.actions != null) {
      components.add(
        ActionsViewWidget(
          actionIds: widget.actions!.map((a) => a['id']).toList(),
        ),
      );
    }

    // components.add(
    //   GraphMutationWidget(
    //     query: addActionMutation,
    //     builder: (addMutation, result) {
    //       return IconButton(
    //         style: IconButton.styleFrom(
    //             backgroundColor: Theme.of(context).primaryColor),
    //         icon: Icon(Icons.add),
    //         onPressed: () {
    //           addMutation({'description': 'New action', 'icon': 'hand'});
    //         },
    //       );
    //     },
    //   ),
    // );

    return components;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...createActionsView()],
    );
  }
}
