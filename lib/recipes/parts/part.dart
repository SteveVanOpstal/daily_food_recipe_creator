import 'package:daily_food_recipe_creator/recipes/actions/actions_edit.dart';
import 'package:flutter/material.dart';

class PartWidget extends StatefulWidget {
  PartWidget({Key? key, this.part}) : super(key: key);

  final dynamic part;

  @override
  _PartWidgetState createState() => _PartWidgetState();
}

class _PartWidgetState extends State<PartWidget> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _changes = {};

  @override
  Widget build(BuildContext context) {
    _changes = widget.part;

    return Scaffold(
      appBar: AppBar(
        title: Text('part'),
      ),
      body: Column(children: [
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.part['title'],
                onChanged: (value) => _changes['title'] = value,
                validator: (value) => value!.isEmpty ? 'empty' : null,
              ),
              // UpdateActionMutationWidget(
              //   builder: (updateMutation, result) {
              //     return ElevatedButton(
              //       child: Text('submit'),
              //       onPressed: () {
              //         if (_formKey.currentState!.validate()) {
              //           _formKey.currentState?.save();
              //           updateMutation(_changes);
              //         }
              //       },
              //     );
              //   },
              // ),
            ],
          ),
        ),
        ActionsEditWidget(
          actions: widget.part['actions'],
        ),
      ]),
    );
  }
}
