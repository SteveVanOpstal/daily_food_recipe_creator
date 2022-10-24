import 'package:daily_food_recipe_creator/recipes/actions/actions_edit.dart';
import 'package:flutter/material.dart';
import 'package:food_icons/food_icons.dart';

import 'action_description_edit.dart';
import 'action_icon_edit.dart';

class ActionEditWidget extends StatefulWidget {
  ActionEditWidget({Key? key, this.action}) : super(key: key);

  final dynamic action;

  @override
  _ActionEditWidgetState createState() => _ActionEditWidgetState();
}

class _ActionEditWidgetState extends State<ActionEditWidget> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _changes = {};

  @override
  Widget build(BuildContext context) {
    _changes = widget.action;

    return Column(children: [
      Form(
        key: _formKey,
        child: Row(
          children: [
            IconButton(
              icon: Icon(_changes['icon'] != null
                  ? FoodIcons.getIcon(_changes['icon'])
                  : Icons.error),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ActionIconEditWidget(
                      action: widget.action,
                      changed: () {
                        setState(() {});
                      },
                    );
                  },
                );
              },
            ),
            TextButton(
              child: Text(widget.action['description'] ?? 'Description'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ActionDescriptionEditWidget(
                      action: widget.action,
                      changed: () {
                        setState(() {});
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 50.0),
        child: ActionsEditWidget(
          actions: widget.action['actions'],
        ),
      ),
    ]);
  }
}
