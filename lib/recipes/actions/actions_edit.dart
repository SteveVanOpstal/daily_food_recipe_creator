import 'package:daily_food_recipe_creator/graphql/mutations/add_action_mutation.dart';
import 'package:daily_food_recipe_creator/recipes/actions/action_view.dart';
import 'package:flutter/material.dart';

class ActionsEditWidget extends StatefulWidget {
  ActionsEditWidget({Key? key, this.actions}) : super(key: key);

  final List<dynamic>? actions;

  @override
  _ActionsEditWidgetState createState() => _ActionsEditWidgetState();
}

class _ActionsEditWidgetState extends State<ActionsEditWidget> {
  createActionEdits() {
    if (widget.actions == null) {
      return [];
    }
    return widget.actions!
        .map((a) => ActionViewWidget(
              action: a,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...createActionEdits(),
        AddActionMutationWidget(
          builder: (addMutation, result) {
            return ElevatedButton(
              child: Row(
                children: [
                  Icon(Icons.add),
                  Text('add'),
                ],
              ),
              onPressed: () {
                addMutation({});
              },
            );
          },
        ),
      ],
    );
  }
}
