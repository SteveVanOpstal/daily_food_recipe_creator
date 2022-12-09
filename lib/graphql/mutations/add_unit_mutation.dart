const addUnitMutation = r'''
mutation ($abbr: String, $singular: String, $plural: String) {
  addUnit(input: [{abbr: $abbr, singular: $singular, plural: $plural}]) {
    unit {
      id
    }
  }
}
''';
