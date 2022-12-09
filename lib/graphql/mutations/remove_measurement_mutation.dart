const removeMeasurementMutation = r'''
mutation ($id: ID!, $unit: UnitRef) {
  updateMeasurement(input: {
              filter: {id: [$id]},
              remove: {
                unit: $unit
              }
            }) {
    measurement {
      id
    }
  }
}
''';
