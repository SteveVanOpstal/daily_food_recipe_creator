import 'package:flutter/material.dart';

class MeasurementProductWidget extends StatelessWidget {
  MeasurementProductWidget({Key? key, required this.measurement})
      : super(key: key);

  final dynamic measurement;

  @override
  Widget build(BuildContext context) {
    if (measurement == null) {
      return Text('');
    }

    double amount = measurement['amount'];
    final product = measurement['product'];

    final productSingular = product['name'];
    final productPlural = product['plural'] ?? productSingular;

    return Text('${amount <= 1.0 ? productSingular : productPlural}');
  }
}
