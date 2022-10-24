import 'package:flutter/material.dart';

class MeasurementWidget extends StatelessWidget {
  MeasurementWidget({Key? key, this.action}) : super(key: key);

  final dynamic action;

  @override
  Widget build(BuildContext context) {
    final measurement = action['measurement'];

    double amount = measurement['amount'];
    final unit = measurement['unit'];
    final product = measurement['product'];

    final name = product['name'];
    final plural = product['plural'];

    return Text('$amount${unit ?? ''} ${amount <= 1.0 ? name : plural}');
  }
}
