import 'package:daily_food_recipe_creator/recipes/actions/action_edit.dart';
import 'package:daily_food_recipe_creator/recipes/actions/action_view.dart';
import 'package:flutter/material.dart';

class ActionsViewWidget extends StatefulWidget {
  ActionsViewWidget({Key? key, this.actions, this.inverse = false})
      : super(key: key);

  final List<dynamic>? actions;
  final bool inverse;

  @override
  _ActionsViewWidgetState createState() => _ActionsViewWidgetState();
}

class _ActionsViewWidgetState extends State<ActionsViewWidget> {
  createActions(List<dynamic> actions) {
    return actions
        .map(
          (action) => ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: widget.inverse
                    ? Colors.white
                    : Theme.of(context).primaryColor,
                onPrimary: widget.inverse
                    ? Theme.of(context).primaryColor
                    : Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
                  return ActionEditWidget(
                    action: action,
                  );
                }),
              );
            },
            child: ActionViewWidget(
              action: action,
              inverse: widget.inverse,
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.actions == null) {
      return Center(
        child: Text('no actions'),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...createActions(widget.actions!)],
    );
  }
}
