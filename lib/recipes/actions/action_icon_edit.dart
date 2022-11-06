import 'package:daily_food_recipe_creator/graphql/mutations/update_action_mutation.dart';
import 'package:flutter/material.dart';
import 'package:food_icons/food_icons.dart';

import '../../graphql/graph_mutation.dart';
import '../../helpers/edit_dialog.dart';

class ActionIconEditWidget extends StatefulWidget {
  ActionIconEditWidget({
    Key? key,
    this.action,
    required this.changed,
  }) : super(key: key);

  final dynamic action;
  final Function changed;

  @override
  _ActionIconEditWidgetState createState() => _ActionIconEditWidgetState();
}

class _ActionIconEditWidgetState extends State<ActionIconEditWidget> {
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
              setState(
                () {
                  _changes['icon'] = iconName;
                },
              );
            },
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    _changes = widget.action;

    return EditDialogWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 120,
            child: GridView.count(
              crossAxisCount: 5,
              children: iconButtons(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              GraphMutationWidget(
                query: updateActionMutation,
                completed: () {
                  widget.changed();
                },
                builder: (updateMutation, result) {
                  return ElevatedButton(
                    child: Text('Save'),
                    onPressed: () {
                      _changes.remove('actions');
                      updateMutation(_changes);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
