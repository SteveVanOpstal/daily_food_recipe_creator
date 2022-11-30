const addMeasurementMutation = r'''
mutation ($amount: Float, $product: ProductRef!) {
  addMeasurement(input: [{amount: $amount, product: $product}]) {
    measurement {
      id
      amount
      unit {
        abbr
        singular
        plural
      }
      product {
        name
        plural
        basic
      }
      static
    }
  }
}
''';
