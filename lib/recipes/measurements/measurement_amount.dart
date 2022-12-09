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
    return Text(measurement['amount'].toString());
  }
}
