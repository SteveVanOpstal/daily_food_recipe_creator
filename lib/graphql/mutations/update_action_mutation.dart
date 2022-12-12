const updateActionMutation = r'''
mutation ($id: ID!, $description: String, $icon: String, $measurement: MeasurementRef, $actions: [ActionRef]) {
  updateAction(input: {
              filter: {id: [$id]},
              set: {
                description: $description
                icon: $icon
                measurement: $measurement
                actions: $actions
              }
            }) {
    action {
      id
    }
  }
}
''';
