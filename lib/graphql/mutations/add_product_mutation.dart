const addProductMutation = r'''
mutation ($name: String!, $plural: String, $measurements: [MeasurementRef], $tips: [TipRef], $basic: Boolean) {
  addProduct(input: [{name: $name, plural: $plural, measurements: $measurements, tips: $tips, basic: $basic}]) {
    product {
      name
    }
  }
}
''';
