const recipesQuery = r'''
query {
  queryRecipe {
    id
    slug
    title
    description,
    parts {
      id
      title
      related {
        id
      }
      actions {
        id
      }
    }
  }
}
''';
