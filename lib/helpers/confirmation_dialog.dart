import 'package:flutter/material.dart';

class ConfirmationDialogWidget extends StatefulWidget {
  ConfirmationDialogWidget({Key? key, required this.confirmed})
      : super(key: key);

  final Function confirmed;

  @override
  _ConfirmationDialogWidgetState createState() =>
      _ConfirmationDialogWidgetState();
}

class _ConfirmationDialogWidgetState extends State<ConfirmationDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: 200,
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Are you sure?'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.confirmed();
                  },
                  child: Text('Delete'),
                ),
              ],
            )
          ],
        ),
      ),
      insetPadding: EdgeInsets.all(8.0),
    );
  }
}
