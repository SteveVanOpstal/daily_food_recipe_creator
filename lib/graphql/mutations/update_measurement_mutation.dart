const updateMeasurementMutation = r'''
mutation ($id: ID!, $amount: Float, $unit: UnitRef, $product: ProductRef) {
  updateMeasurement(input: {
              filter: {id: [$id]},
              set: {
                amount: $amount
                unit: $unit
                product: $product
              }
            }) {
    measurement {
      id
    }
  }
}
''';
