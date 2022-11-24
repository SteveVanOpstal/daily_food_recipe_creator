const addPartMutation = r'''
mutation ($title: String!) {
  addPart(input: {
            title: $title 
            actions: [{description: "New Action", icon: "hand"}]
          }) {
    part {
      id
    }
  }
}
''';
