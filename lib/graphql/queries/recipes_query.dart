const recipesQuery = r'''
query {
  queryRecipe {
    id
    slug
    title
    description
    draft
    measurements {
      id
      amount
      unit {
        abbr
        singular
        plural
      }
      product {
        name
        plural
        basic
      }
      static
    }
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
