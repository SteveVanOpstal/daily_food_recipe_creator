const deleteActionMutation = r'''
mutation ($id: ID!) {
  deleteAction(filter: {id: [$id]}) {
    action {
      id
    }
  }
}
''';
