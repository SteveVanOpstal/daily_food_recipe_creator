const updateRecipeMutation = r'''
mutation ($id: ID!, $title: String, $slug: String, $description: String, $parts: [PartRef]) {
  updateRecipe(input: {
              filter: {id: [$id]},
              set: {
                title: $title
                slug: $slug
                description: $description
                parts: $parts
              }
            }) {
    recipe {
      id
      title
      slug
      description
      parts {
        id
      }
    }
  }
}
''';
