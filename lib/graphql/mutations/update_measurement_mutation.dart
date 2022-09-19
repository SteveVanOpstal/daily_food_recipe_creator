const updateMeasurementMutation = r'''
        mutation ($id: ID!, $amount: String) {
          updateMeasurement(input: {
                      filter: {id: [$id]},
                      set: {
                        amount: $amount
                      }
                    }) {
            action {
              id
            }
          }
        }
      ''';
