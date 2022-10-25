import 'package:flutter/material.dart';

import '../../helpers/edit_dialog.dart';
import 'graph_mutation.dart';

class MutationDialogWidget extends StatefulWidget {
  MutationDialogWidget({
    Key? key,
    required this.subject,
    required this.subjectKey,
    required this.query,
    required this.changed,
    this.validator,
  }) : super(key: key);

  final dynamic subject;
  final String subjectKey;
  final String query;
  final Function changed;
  final String? Function(String?)? validator;

  @override
  _MutationDialogWidgetState createState() => _MutationDialogWidgetState();
}

class _MutationDialogWidgetState extends State<MutationDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _changes = {};

  @override
  Widget build(BuildContext context) {
    _changes = widget.subject;

    return EditDialogWidget(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              initialValue: widget.subject[widget.subjectKey],
              onChanged: (value) => _changes[widget.subjectKey] = value,
              validator: widget.validator,
              autofocus: true,
              maxLines: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                GraphMutationWidget(
                  query: widget.query,
                  builder: (updateMutation, result) {
                    return ElevatedButton(
                      child: Text('Save'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          updateMutation(_changes);
                          widget.changed();
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
