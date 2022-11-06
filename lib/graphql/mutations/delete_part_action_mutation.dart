const deletePartActionMutation = r'''
mutation ($id: ID!, $actionId: ID!) {
  updatePart(input: {
              filter: {id: [$id]},
              remove: {
                actions: [{id: $actionId}]
              }
            }) {
    part {
      id
      actions {
        id
      }
    }
  }
}
''';
