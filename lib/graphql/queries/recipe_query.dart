const recipeQuery = r'''
query ($id: ID!) {
  queryRecipe(filter: {id: [$id]}) {
    title
    description
  }
}
''';
