const updatePartMutation = r'''
mutation ($id: ID!, $title: String, $actions: [ActionRef]) {
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
