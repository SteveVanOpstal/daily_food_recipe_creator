import 'package:flutter/material.dart';

import '../measurements/measurement.dart';

class ActionDescriptionWidget extends StatelessWidget {
  ActionDescriptionWidget({Key? key, this.action}) : super(key: key);

  final dynamic action;

  @override
  Widget build(BuildContext context) {
    String description = action['description'];

    final descriptionSplits = description.split(RegExp('{[1]}'));

    return Row(
      children: [
        Text(descriptionSplits[0]),
        MeasurementWidget(action: action),
        Text(descriptionSplits.length >= 2 ? descriptionSplits[1] : ''),
      ],
    );
  }
}
