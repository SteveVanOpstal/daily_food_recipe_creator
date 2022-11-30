const addProductMutation = r'''
mutation ($name: String, $plural: String, $plural: String, $measurements: [Measurement], tips: [Tip], basic: Boolean) {
  addProduct(input: [{name: $name, plural: $plural, measurements: $measurements, tips: $tips, basic: $basic}]) {
    product {
      id
    }
  }
}
''';
