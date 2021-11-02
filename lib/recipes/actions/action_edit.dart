import 'package:daily_food_recipe_creator/graphql/mutations/update_action_mutation.dart';
import 'package:daily_food_recipe_creator/recipes/actions/actions_edit.dart';
import 'package:flutter/material.dart';
import 'package:food_icons/food_icons.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text('action'),
      ),
      body: Column(children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.action['description'],
                onChanged: (value) => _changes['description'] = value,
                validator: (value) => value!.isEmpty ? 'empty' : null,
              ),
              Flex(
                direction: Axis.horizontal,
                children: iconButtons(),
              ),
              UpdateActionMutationWidget(
                builder: (updateMutation, result) {
                  return ElevatedButton(
                    child: Text('submit'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState?.save();
                        updateMutation(_changes);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
        ActionsEditWidget(
          actions: widget.action['actions'],
        ),
      ]),
    );
  }
}
