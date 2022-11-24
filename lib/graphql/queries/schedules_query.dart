const schedulesQuery = r'''
query {
  querySchedule(order: {asc: date}) {
    id
    date
    recipe {
      id
    }
  }
}
''';
// query {
//   querySchedule(filter: {date: {between: {min: "", max: ""}}}) {
//     id
//     date
//     recipe {
//       id
//     }
//   }
// }
