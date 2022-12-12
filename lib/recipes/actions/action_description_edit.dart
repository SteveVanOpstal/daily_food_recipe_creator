import 'package:daily_food_recipe_creator/graphql/mutations/update_action_mutation.dart';
import 'package:daily_food_recipe_creator/recipes/actions/action_description.dart';
import 'package:flutter/material.dart';

import '../../graphql/graph_mutation.dart';
import '../../helpers/edit_dialog.dart';
import '../measurements/measurement.dart';

class ActionDescriptionEditWidget extends StatefulWidget {
  ActionDescriptionEditWidget(
      {Key? key, this.recipe, this.action, required this.changed});

  final dynamic recipe;
  final dynamic action;
  final Function changed;

  @override
  _ActionDescriptionEditWidgetState createState() =>
      _ActionDescriptionEditWidgetState();
}

class _ActionDescriptionEditWidgetState
    extends State<ActionDescriptionEditWidget> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _previousValue = {};

  @override
  Widget build(BuildContext context) {
    _previousValue = widget.action;

    return EditDialogWidget(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'description',
              style:
                  DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),
            ),
            TextFormField(
              initialValue: widget.action['description'],
              onChanged: (value) {
                setState(() {
                  widget.action['description'] = value;
                });
              },
              validator: (value) => value!.isEmpty ? 'empty' : null,
              autofocus: true,
              maxLines: 3,
            ),
            DropdownButton(
              value: widget.action['measurement']['id'],
              items: (widget.recipe['measurements'] as List).map((measurement) {
                return DropdownMenuItem(
                  child: MeasurementWidget(
                    measurement: measurement,
                  ),
                  value: measurement['id'],
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  widget.action['measurement'] = {'id': value};
                });
              },
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ActionDescriptionWidget(
                  action: widget.action,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.action['description'] =
                        _previousValue['description'];
                    widget.action['measurement'] =
                        _previousValue['measurement'];
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
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          updateMutation({
                            'id': widget.action['id'],
                            'description': widget.action['description'],
                            'measurement': {
                              'id': widget.action['measurement']['id']
                            }
                          });
                          Navigator.pop(context);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
