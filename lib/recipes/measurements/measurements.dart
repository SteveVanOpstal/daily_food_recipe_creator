import 'package:daily_food_recipe_creator/graphql/mutations/add_measurement_mutation.dart';
import 'package:daily_food_recipe_creator/graphql/mutations/update_recipe_mutation.dart';
import 'package:daily_food_recipe_creator/recipes/measurements/measurement_amount.dart';
import 'package:daily_food_recipe_creator/recipes/measurements/measurement_amount_edit.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../graphql/graph_mutation.dart';
import '../../graphql/graph_query.dart';
import '../../graphql/queries/products_query.dart';
import '../../graphql/queries/units_query.dart';
import 'measurement_product.dart';
import 'measurement_product_edit.dart';
import 'measurement_unit.dart';
import 'measurement_unit_edit.dart';

class MeasurementsWidget extends StatefulWidget {
  MeasurementsWidget({Key? key, required this.recipe, required this.changes})
      : super(key: key);

  final dynamic recipe;
  final VoidCallback changes;

  @override
  State<MeasurementsWidget> createState() => _MeasurementsWidgetState();
}

class _MeasurementsWidgetState extends State<MeasurementsWidget> {
  buildAddMeasurementButton() {
    return GraphMutationWidget(
      query: addMeasurementMutation,
      builder: (addMutation, _) {
        return GraphMutationWidget(
          query: updateRecipeMutation,
          builder: (updateMutation, _) {
            return ElevatedButton.icon(
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              icon: Icon(Icons.add),
              label: Text('Add measurement'),
              onPressed: () async {
                final result = addMutation({
                  'amount': 1.0,
                  'product': {'name': 'placeholder'},
                });
                final networkResult = await result.networkResult;
                final newMeasurement =
                    networkResult?.data?['addMeasurement']['measurement'][0];

                if (newMeasurement.isNotEmpty) {
                  setState(() {
                    widget.recipe['measurements']
                        .add({'__typename': 'Measurement', ...newMeasurement});
                  });
                  final measurements = (widget.recipe['measurements'] as List)
                      .map((a) => {'id': a['id']})
                      .toList();
                  updateMutation({
                    'id': widget.recipe['id'],
                    'measurements': measurements
                  });
                }
              },
            );
          },
        );
      },
    );
  }

  buildMeasurements(List<dynamic> measurements) {
    return measurements.map(
      (measurement) => Row(
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MeasurementAmountEditWidget(
                    measurement: measurement,
                    changes: () {
                      widget.changes();
                    },
                  );
                },
              );
            },
            child: MeasurementAmountWidget(measurement: measurement),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return GraphQueryWidget(
                    query: unitsQuery,
                    builder: (
                      QueryResult result, {
                      Refetch? refetch,
                      FetchMore? fetchMore,
                    }) {
                      if (result.isLoading || result.data == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return MeasurementUnitEditWidget(
                        measurement: measurement,
                        allUnits: result.data!["queryUnit"] as List<dynamic>,
                        changes: () {
                          setState(() {});
                        },
                      );
                    },
                  );
                },
              );
            },
            child: MeasurementUnitWidget(measurement: measurement),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return GraphQueryWidget(
                    query: productsQuery,
                    builder: (
                      QueryResult result, {
                      Refetch? refetch,
                      FetchMore? fetchMore,
                    }) {
                      if (result.isLoading || result.data == null) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return MeasurementProductEditWidget(
                        measurement: measurement,
                        allProducts:
                            result.data!["queryProduct"] as List<dynamic>,
                        changes: () {
                          setState(() {});
                        },
                      );
                    },
                  );
                },
              );
            },
            child: MeasurementProductWidget(measurement: measurement),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.recipe['measurements'] == null ||
        widget.recipe['measurements'].isEmpty) {
      return buildAddMeasurementButton();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          children: [
            ...buildMeasurements(widget.recipe['measurements']),
            buildAddMeasurementButton(),
          ],
        ),
      ),
    );
  }
}
