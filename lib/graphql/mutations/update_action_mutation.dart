const updateActionMutation = r'''
        mutation ($id: ID!, $description: String, $icon: String, $actions: [Action]) {
          updateAction(input: {
                      filter: {id: [$id]},
                      set: {
                        description: $description
                        icon: $icon
                        actions: $actions
                      }
                    }) {
            action {
              id
            }
          }
        }
      ''';
