import 'package:daily_food_recipe_creator/graphql/graph_query.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'client_provider.dart';
import 'recipes/recipes.dart';

final host = 'localhost:8080';
final graphqlEndpoint =
    'https://billowing-leaf.eu-central-1.aws.cloud.dgraph.io/graphql';
// final subscriptionEndpoint = 'ws://$host/subscriptions';

void main() async {
  await initHiveForFlutter();
  runApp(MyApp());
}

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClientProvider(
      uri: graphqlEndpoint,
      // subscriptionUri: subscriptionEndpoint,
      child: MaterialApp(
        scaffoldMessengerKey: rootScaffoldMessengerKey,
        title: 'Daily food, recipe creator',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          primaryColor: Colors.deepPurple,
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
      body: GraphQueryWidget(
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
          },
          query: r'''
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
          '''),
    );
  }
}
