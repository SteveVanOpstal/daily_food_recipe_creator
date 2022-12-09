import 'package:daily_food_recipe_creator/graphql/graph_mutation.dart';
import 'package:daily_food_recipe_creator/graphql/mutations/update_measurement_mutation.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';

import '../../graphql/mutations/add_unit_mutation.dart';
import '../../graphql/mutations/remove_measurement_mutation.dart';
import '../../helpers/edit_dialog.dart';

class MeasurementUnitEditWidget extends StatefulWidget {
  MeasurementUnitEditWidget(
      {Key? key,
      this.measurement,
      required this.allUnits,
      required this.changes})
      : super(key: key);

  final dynamic measurement;
  final List<dynamic> allUnits;
  final VoidCallback changes;

  @override
  _MeasurementUnitEditWidgetState createState() =>
      _MeasurementUnitEditWidgetState();
}

class _MeasurementUnitEditWidgetState extends State<MeasurementUnitEditWidget> {
  final _formKey = GlobalKey<FormState>();
  String _filter = '';

  buildAddUnitButton() {
    Map<String, dynamic> newUnit = {};
    return ElevatedButton.icon(
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      icon: Icon(Icons.add),
      label: Text('Add unit'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return EditDialogWidget(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Abbreviation',
                        hintText:
                            'The short form of the unit, for example `l` for litre',
                      ),
                      onChanged: (value) {
                        newUnit['abbr'] = value;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Singular',
                        hintText:
                            'The singular form of the unit, for example `litre` for litre',
                      ),
                      onChanged: (value) {
                        newUnit['singular'] = value;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Plural',
                        hintText:
                            'The plural form of the unit, for example `litres` for litre',
                      ),
                      onChanged: (value) {
                        newUnit['plural'] = value;
                      },
                    ),
                    FormField(
                      initialValue: false,
                      builder: (FormFieldState<bool> field) {
                        return Switch(
                          onChanged: (value) {
                            field.didChange(value);
                          },
                          value: field.value!,
                        );
                      },
                    ),
                    GraphMutationWidget(
                      query: addUnitMutation,
                      builder: (addMutation, _) {
                        return ElevatedButton(
                          child: Text('submit'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState?.save();
                              addMutation(newUnit);
                              widget.allUnits.add(newUnit);
                              Navigator.pop(context);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final fuse = Fuzzy<dynamic>(
      widget.allUnits,
      options: FuzzyOptions(keys: [
        WeightedKey(
          name: 'abbr',
          getter: (item) => item["abbr"],
          weight: 0.5,
        ),
        WeightedKey(
          name: 'singular',
          getter: (item) => item["singular"],
          weight: 1,
        ),
        WeightedKey(
          name: 'plural',
          getter: (item) => item["plural"],
          weight: 1,
        ),
      ]),
    );

    final units = fuse.search(_filter).map((r) => r.item).toList();

    final currentUnit = widget.measurement['unit'];

    return Scaffold(
      appBar: AppBar(
        title: Text('action'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) => {
                setState(() {
                  _filter = value;
                })
              },
            ),
          ),
          Wrap(
            children: [
              SizedBox(
                width: 150,
                height: 80,
                child: Card(
                  child: Center(
                    child: Text(currentUnit == null ? '' : currentUnit['abbr']),
                  ),
                ),
              ),
              GraphMutationWidget(
                query: removeMeasurementMutation,
                completed: () {
                  widget.measurement['unit'] = null;
                  Navigator.pop(context);
                  widget.changes();
                },
                builder: (updateMutation, result) {
                  return SizedBox(
                    width: 150,
                    height: 80,
                    child: ElevatedButton(
                      child: Text('Remove'),
                      onPressed: () {
                        if (currentUnit != null) {
                          updateMutation({
                            'id': widget.measurement['id'],
                            'unit': {
                              'abbr': currentUnit['abbr'],
                            }
                          });
                        }
                      },
                    ),
                  );
                },
              ),
              ...units.map(
                (unit) => GraphMutationWidget(
                  query: updateMeasurementMutation,
                  completed: () {
                    widget.measurement['unit'] = unit;
                    Navigator.pop(context);
                    widget.changes();
                  },
                  builder: (updateMutation, result) {
                    return SizedBox(
                      width: 150,
                      height: 80,
                      child: ElevatedButton(
                        child: Column(
                          children: [
                            Text(unit['abbr']),
                            unit['singular'] == null
                                ? Text('')
                                : Text(unit['singular']),
                          ],
                        ),
                        onPressed: () {
                          updateMutation({
                            'id': widget.measurement['id'],
                            'unit': {
                              'abbr': unit['abbr'],
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          buildAddUnitButton(),
        ],
      ),
    );
  }
}
