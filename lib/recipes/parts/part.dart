import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PartWidget extends StatefulWidget {
  PartWidget({Key? key, this.part}) : super(key: key);

  final dynamic part;

  @override
  _PartWidgetState createState() => _PartWidgetState();
}

class _PartWidgetState extends State<PartWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [],
      ),
    );
  }
}
