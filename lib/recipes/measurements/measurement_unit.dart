import 'package:flutter/material.dart';

class MeasurementUnitWidget extends StatelessWidget {
  MeasurementUnitWidget({Key? key, required this.measurement})
      : super(key: key);

  final dynamic measurement;

  @override
  Widget build(BuildContext context) {
    if (measurement == null) {
      return Text('');
    }

    final unit = measurement['unit'];

    String unitName = '';

    if (unit != null) {
      if (unit['abbr'] != null) {
        unitName = ' ' + unit['abbr'];
      } else {
        final unitSingular = unit['singular'];
        final unitPlural = unit['plural'] ?? unitSingular;
        unitName =
            ' ' + (measurement['amount'] <= 1.0 ? unitSingular : unitPlural);
      }
    }

    return Text(unitName);
  }
}
