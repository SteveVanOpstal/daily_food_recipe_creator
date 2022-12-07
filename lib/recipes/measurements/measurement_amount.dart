import 'package:flutter/material.dart';

class MeasurementAmountWidget extends StatelessWidget {
  MeasurementAmountWidget({Key? key, required this.measurement})
      : super(key: key);

  final dynamic measurement;

  @override
  Widget build(BuildContext context) {
    if (measurement == null) {
      return Text('');
    }

    double amount = measurement['amount'];
    final unit = measurement['unit'];

    String unitName = '';

    if (unit != null) {
      if (unit['abbr'] != null) {
        unitName = ' ' + unit['abbr'];
      } else {
        final unitSingular = unit['singular'];
        final unitPlural = unit['plural'] ?? unitSingular;
        unitName = ' ' + (amount <= 1.0 ? unitSingular : unitPlural);
      }
    }

    return Text('$amount$unitName');
  }
}
