import 'package:daily_food_recipe_creator/graphql/graph_mutation.dart';
import 'package:daily_food_recipe_creator/graphql/mutations/update_measurement_mutation.dart';
import 'package:flutter/material.dart';
import 'package:fuzzy/fuzzy.dart';

import '../../graphql/mutations/add_product_mutation.dart';
import '../../helpers/edit_dialog.dart';

class MeasurementProductEditWidget extends StatefulWidget {
  MeasurementProductEditWidget(
      {Key? key,
      this.measurement,
      required this.allProducts,
      required this.changes})
      : super(key: key);

  final dynamic measurement;
  final List<dynamic> allProducts;
  final VoidCallback changes;

  @override
  _MeasurementProductEditWidgetState createState() =>
      _MeasurementProductEditWidgetState();
}

class _MeasurementProductEditWidgetState
    extends State<MeasurementProductEditWidget> {
  final _formKey = GlobalKey<FormState>();
  String _filter = '';

  buildAddProductButton() {
    Map<String, dynamic> newProduct = {'basic': false};
    return ElevatedButton.icon(
      style: IconButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      icon: Icon(Icons.add),
      label: Text('Add product'),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return EditDialogWidget(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Name',
                        hintText:
                            'The singular form of the product, for example `garlic clove` for garlic',
                      ),
                      onChanged: (value) {
                        newProduct['name'] = value;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Plural',
                        hintText:
                            'The plural form of the product, for example `cloves of garlic` for garlic',
                      ),
                      onChanged: (value) {
                        newProduct['plural'] = value;
                      },
                    ),
                    FormField(
                      initialValue: false,
                      builder: (FormFieldState<bool> field) {
                        return Switch(
                          onChanged: (value) {
                            field.didChange(value);
                          },
                          value: field.value!,
                        );
                      },
                    ),
                    GraphMutationWidget(
                      query: addProductMutation,
                      builder: (addMutation, _) {
                        return ElevatedButton(
                          child: Text('submit'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState?.save();
                              addMutation(newProduct);
                              widget.allProducts.add(newProduct);
                              Navigator.pop(context);
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final fuse = Fuzzy<dynamic>(
      widget.allProducts,
      options: FuzzyOptions(keys: [
        WeightedKey(
          name: 'name',
          getter: (item) => item["name"],
          weight: 1,
        ),
        WeightedKey(
          name: 'plural',
          getter: (item) => item["plural"],
          weight: 1,
        ),
      ]),
    );

    final products = fuse.search(_filter).map((r) => r.item).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('action'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              onChanged: (value) => {
                setState(() {
                  _filter = value;
                })
              },
            ),
          ),
          Wrap(
            children: [
              SizedBox(
                width: 150,
                height: 80,
                child: Card(
                  child: Center(
                    child: Text(widget.measurement['product']['name']),
                  ),
                ),
              ),
              ...products.map(
                (product) => GraphMutationWidget(
                  query: updateMeasurementMutation,
                  completed: () {
                    widget.measurement['product'] = product;
                    Navigator.pop(context);
                    widget.changes();
                  },
                  builder: (updateMutation, result) {
                    return SizedBox(
                      width: 150,
                      height: 80,
                      child: ElevatedButton(
                        child: Text(product['name']),
                        onPressed: () {
                          updateMutation({
                            'id': widget.measurement['id'],
                            'product': {
                              'name': product['name'],
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          buildAddProductButton(),
        ],
      ),
    );
  }
}
