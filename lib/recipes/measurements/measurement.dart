import 'package:flutter/material.dart';

class MeasurementWidget extends StatelessWidget {
  MeasurementWidget({Key? key, required this.action}) : super(key: key);

  final dynamic action;

  @override
  Widget build(BuildContext context) {
    if (action == null) {
      return Text('');
    }

    final measurement = action['measurement'];

    if (measurement == null) {
      return Text('');
    }

    double amount = measurement['amount'];
    final unit = measurement['unit'];
    final product = measurement['product'];

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

    final productSingular = product['name'];
    final productPlural = product['plural'] ?? productSingular;

    return Text(
        '$amount$unitName ${amount <= 1.0 ? productSingular : productPlural}');
  }
}
