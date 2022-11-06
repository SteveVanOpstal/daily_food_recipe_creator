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
    this.children,
  }) : super(key: key);

  final dynamic subject;
  final String subjectKey;
  final String query;
  final Function changed;
  final String? Function(String?)? validator;
  final List<Widget>? children;

  @override
  _MutationDialogWidgetState createState() => _MutationDialogWidgetState();
}

class _MutationDialogWidgetState extends State<MutationDialogWidget> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _previousValue = {};

  @override
  Widget build(BuildContext context) {
    _previousValue = widget.subject;

    return EditDialogWidget(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFormField(
              initialValue: widget.subject[widget.subjectKey],
              onChanged: (value) => widget.subject[widget.subjectKey] = value,
              validator: widget.validator,
              autofocus: true,
              maxLines: 3,
            ),
            ...(widget.children ?? []),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    widget.subject[widget.subjectKey] =
                        _previousValue[widget.subjectKey];
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                GraphMutationWidget(
                  query: widget.query,
                  completed: () {
                    widget.changed();
                  },
                  builder: (updateMutation, result) {
                    return ElevatedButton(
                      child: Text('Save'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState?.save();
                          updateMutation(widget.subject);
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
