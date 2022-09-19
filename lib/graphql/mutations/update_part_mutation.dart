const updatePartMutation = r'''
        mutation ($id: ID!, $title: String, $actions: [Action]) {
          updatePart(input: {
                      filter: {id: [$id]},
                      set: {
                        title: $title
                        actions: $actions
                      }
                    }) {
            part {
              id
            }
          }
        }
      ''';
