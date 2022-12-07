import 'package:daily_food_recipe_creator/graphql/graph_mutation.dart';
import 'package:daily_food_recipe_creator/graphql/mutations/update_measurement_mutation.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';

class MeasurementProductEditWidget extends StatefulWidget {
  MeasurementProductEditWidget(
      {Key? key,
      this.measurement,
      required this.allProducts,
      required this.changes})
      : super(key: key);

  final dynamic measurement;
  final List allProducts;
  final VoidCallback changes;

  @override
  _MeasurementProductEditWidgetState createState() =>
      _MeasurementProductEditWidgetState();
}

class _MeasurementProductEditWidgetState
    extends State<MeasurementProductEditWidget> {
  String _filter = '';

  @override
  Widget build(BuildContext context) {
    final fuse = Fuzzy(widget.allProducts);
    final products = fuse.search(_filter).map((r) => r.item);

    return Scaffold(
      appBar: AppBar(
        title: Text('action'),
      ),
      body: Column(children: [
        TextFormField(
          onChanged: (value) => {
            setState(() {
              _filter = value;
            })
          },
        ),
        GraphMutationWidget(
            query: updateMeasurementMutation,
            completed: () {
              widget.changes();
            },
            builder: (updateMutation, result) {
              return Column(children: [
                ...products.map(
                  (product) => ElevatedButton(
                    child: Text(product['name']),
                    onPressed: () {},
                  ),
                ),
              ]);
            }
            // ,ElevatedButton(
            //       child: Text('submit'),
            //       onPressed: () {
            //         // if (_formKey.currentState!.validate()) {
            //         //   _formKey.currentState?.save();
            //         //   updateMutation({
            //         //     'id': _changes['id'],
            //         //     'amount': _changes['amount']
            //         //   });
            //         // }
            //       },
            //     );
            ),
      ]),
    );
  }
}
