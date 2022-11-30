const addUnitMutation = r'''
mutation ($abbr: String, $singular: String, $plural: String, $relative: Boolean) {
  addUnit(input: [{abbr: $abbr, singular: $singular, plural: $plural, relative: $relative}]) {
    unit {
      id
    }
  }
}
''';
