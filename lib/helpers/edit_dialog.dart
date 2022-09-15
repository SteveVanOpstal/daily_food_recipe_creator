import 'package:daily_food_recipe_creator/graphql/mutations/update_recipe_mutation.dart';
import 'package:flutter/material.dart';

class EditDialogWidget extends StatefulWidget {
  EditDialogWidget({Key? key, this.child}) : super(key: key);

  final Widget? child;

  @override
  _EditDialogWidgetState createState() => _EditDialogWidgetState();
}

class _EditDialogWidgetState extends State<EditDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: 300,
        height: 200,
        child: widget.child,
      ),
      insetPadding: EdgeInsets.all(8.0),
    );
  }
}
