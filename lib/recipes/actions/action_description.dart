import 'package:flutter/material.dart';

import '../measurements/measurement.dart';

class ActionDescriptionWidget extends StatelessWidget {
  ActionDescriptionWidget({Key? key, this.action}) : super(key: key);

  final dynamic action;

  @override
  Widget build(BuildContext context) {
    String description = action['description'];

    description.split(RegExp('\{\d\}'));

    return Row(
      children: [
        Text(description),
        Text(' '),
        MeasurementWidget(),
        Text(' '),
      ],
    );
  }
}
