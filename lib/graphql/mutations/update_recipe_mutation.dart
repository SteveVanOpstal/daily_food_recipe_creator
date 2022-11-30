const updateRecipeMutation = r'''
mutation ($id: ID!, $title: String, $slug: String, $description: String, $measurements: [MeasurementRef], $parts: [PartRef]) {
  updateRecipe(input: {
              filter: {id: [$id]},
              set: {
                title: $title
                slug: $slug
                description: $description
                parts: $parts
                measurements: $measurements
              }
            }) {
    recipe {
      id
      title
      slug
      description
      measurements {
        id
      }
      parts {
        id
      }
    }
  }
}
''';
