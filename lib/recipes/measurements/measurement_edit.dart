import 'package:daily_food_recipe_creator/graphql/graph_mutation.dart';
import 'package:daily_food_recipe_creator/graphql/mutations/update_measurement_mutation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MeasurementEditWidget extends StatefulWidget {
  MeasurementEditWidget({Key? key, this.measurement, required this.changes})
      : super(key: key);

  final dynamic measurement;
  final VoidCallback changes;

  @override
  _MeasurementEditWidgetState createState() => _MeasurementEditWidgetState();
}

class _MeasurementEditWidgetState extends State<MeasurementEditWidget> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _changes = {};

  @override
  Widget build(BuildContext context) {
    _changes = widget.measurement;

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
                initialValue: widget.measurement['amount'],
                onChanged: (value) => _changes['amount'] = value,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              GraphMutationWidget(
                query: updateMeasurementMutation,
                completed: () {
                  widget.changes();
                },
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
      ]),
    );
  }
}
