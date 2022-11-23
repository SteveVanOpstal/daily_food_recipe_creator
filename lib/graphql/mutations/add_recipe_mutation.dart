const addRecipeMutation = r'''
mutation ($slug: String!, $title: String!) {
  addRecipe(input: [{slug: $slug, title: $title, draft: true}]) {
    recipe {
      id
    }
  }
}
''';
