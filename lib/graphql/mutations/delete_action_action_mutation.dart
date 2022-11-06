const updateActionActionMutation = r'''
mutation ($id: ID!, $actionId: ID!) {
  updateAction(input: {
              filter: {id: [$id]},
              remove: {
                actions: [{id: $actionId}]
              }
            }) {
    action {
      id
    }
  }
}
''';
