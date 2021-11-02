import 'package:daily_food_recipe_creator/graphql/mutations/update_measurement_mutation.dart';
import 'package:daily_food_recipe_creator/recipes/actions/actions_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                initialValue: widget.action['amount'],
                onChanged: (value) => _changes['amount'] = value,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              UpdateMeasurementMutationWidget(
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
