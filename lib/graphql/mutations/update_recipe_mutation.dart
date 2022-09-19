const updateRecipeMutation = r'''
        mutation ($id: ID!, $title: String, $slug: String, $description: String) {
          updateRecipe(input: {
                        filter: {id: [$id]},
                        set: {
                          title: $title
                          slug: $slug
                          description: $description
                        }
                      }) {
            recipe {
              id
              title
              slug
              description
            }
          }
        }
      ''';
