const updatePartMutation = r'''
mutation ($id: ID!, $actions: [ActionRef]) {
  updatePart(input: {
              filter: {id: [$id]},
              set: {
                actions: $actions
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
