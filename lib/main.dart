import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'client_provider.dart';
import 'recipes/recipes.dart';

final host = 'localhost:8080';
final graphqlEndpoint = 'http://$host/graphql';
final subscriptionEndpoint = 'ws://$host/subscriptions';

void main() async {
  await initHiveForFlutter();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClientProvider(
      uri: graphqlEndpoint,
      subscriptionUri: subscriptionEndpoint,
      child: MaterialApp(
        title: 'Daily food, recipe creator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'),
      ),
      body: Query(
          options: QueryOptions(
            document: gql(r'''
            query {
              queryRecipe(filter: {description: {alloftext: "greek"}}) {
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
          '''),
          ),
          builder: (
            QueryResult result, {
            Refetch? refetch,
            FetchMore? fetchMore,
          }) {
            return result.isLoading || result.data == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RecipesWidget(recipes: result.data!['queryRecipe']);
          }),
    );
  }
}
