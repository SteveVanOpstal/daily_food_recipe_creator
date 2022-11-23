import 'package:flutter/material.dart';

class EditDialogWidget extends StatefulWidget {
  EditDialogWidget({Key? key, this.child, this.height = 230}) : super(key: key);

  final Widget? child;
  final double height;

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
        height: widget.height,
        child: widget.child,
      ),
      insetPadding: EdgeInsets.all(8.0),
    );
  }
}
