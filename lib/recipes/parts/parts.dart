import 'package:daily_food_recipe_creator/recipes/actions/actions_view.dart';
import 'package:daily_food_recipe_creator/recipes/parts/part.dart';
import 'package:flutter/material.dart';

class PartsWidget extends StatefulWidget {
  PartsWidget({Key? key, this.parts}) : super(key: key);

  final List<dynamic>? parts;

  @override
  _PartsWidgetState createState() => _PartsWidgetState();
}

class _PartsWidgetState extends State<PartsWidget> {
  createPartButton(dynamic part) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(part['title']),
        ActionsViewWidget(
          actions: part['actions'],
          inverse: true,
        )
      ],
    );
  }

  createParts(List<dynamic> parts) {
    var recipeParts = [];
    for (var part in parts) {
      recipeParts.add(ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
              return PartWidget(part: part);
            }));
          },
          child: createPartButton(part)));
    }
    return recipeParts;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.parts == null) {
      return Center(
        child: Text('no parts'),
      );
    }
    return Column(
      children: [
        ...createParts(widget.parts!),
      ],
    );
  }
}
