import 'package:daily_food_recipe_creator/recipes/measurements/measurement_amount.dart';
import 'package:daily_food_recipe_creator/recipes/measurements/measurement_product.dart';
import 'package:daily_food_recipe_creator/recipes/measurements/measurement_unit.dart';
import 'package:flutter/material.dart';

class MeasurementWidget extends StatelessWidget {
  MeasurementWidget({Key? key, required this.measurement}) : super(key: key);

  final dynamic measurement;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MeasurementAmountWidget(measurement: measurement),
        MeasurementUnitWidget(measurement: measurement),
        Text(' '),
        MeasurementProductWidget(measurement: measurement),
      ],
    );
  }
}
