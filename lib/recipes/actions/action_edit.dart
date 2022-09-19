import 'package:daily_food_recipe_creator/graphql/mutations/update_action_mutation.dart';
import 'package:daily_food_recipe_creator/recipes/actions/actions_edit.dart';
import 'package:flutter/material.dart';
import 'package:food_icons/food_icons.dart';

import 'action_description_edit.dart';

class ActionEditWidget extends StatefulWidget {
  ActionEditWidget({Key? key, this.action}) : super(key: key);

  final dynamic action;

  @override
  _ActionEditWidgetState createState() => _ActionEditWidgetState();
}

class _ActionEditWidgetState extends State<ActionEditWidget> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _changes = {};

  iconButtons() {
    return FoodIcons.iconNames
        .map(
          (iconName) => IconButton(
            color: _changes['icon'] == iconName
                ? Theme.of(context).primaryColor
                : null,
            icon: Icon(FoodIcons.getIcon(iconName)),
            onPressed: () {
              setState(() {
                _changes['icon'] = iconName;
              });
            },
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    _changes = widget.action;

    return Column(children: [
      Form(
        key: _formKey,
        child: Column(
          children: [
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
            Flex(
              direction: Axis.horizontal,
              children: iconButtons(),
            ),
          ],
        ),
      ),
      ActionsEditWidget(
        actions: widget.action['actions'],
      ),
    ]);
  }
}
