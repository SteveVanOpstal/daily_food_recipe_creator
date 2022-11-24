const addScheduleMutation = r'''
mutation ($date: DateTime!, $recipeId: ID!) {
  addSchedule(input: [{date: $date, recipe: {id: $recipeId}}]) {
    schedule {
      id
    }
  }
}
''';
