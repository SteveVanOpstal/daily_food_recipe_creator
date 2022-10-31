const addActionMutation = r'''
mutation ($description: String!, $icon: String) {
  addAction(input: [{description: $description, icon: $icon}]) {
    action {
      id
    }
  }
}
''';
