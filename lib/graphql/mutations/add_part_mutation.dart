const addPartMutation = r'''
mutation ($title: String!) {
  addPart(input: {title: $title}) {
    part {
      id
    }
  }
}
''';
