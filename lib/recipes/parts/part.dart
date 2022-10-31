import 'dart:developer';

import 'package:daily_food_recipe_creator/graphql/mutations/update_part_mutation.dart';
import 'package:daily_food_recipe_creator/recipes/actions/actions_edit.dart';
import 'package:daily_food_recipe_creator/recipes/parts/part_title_edit.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../graphql/graph_mutation.dart';
import '../../graphql/mutations/add_action_mutation.dart';

class PartWidget extends StatefulWidget {
  PartWidget({Key? key, this.part}) : super(key: key);

  final dynamic part;

  @override
  _PartWidgetState createState() => _PartWidgetState();
}

class _PartWidgetState extends State<PartWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          child: Text(
            widget.part['title'] ?? 'Title',
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return PartTitleEditWidget(
                  part: widget.part,
                  changed: () {
                    setState(() {});
                  },
                );
              },
            );
          },
        ),
        ActionsEditWidget(
          actions: widget.part['actions'],
        ),
        GraphMutationWidget(
          query: addActionMutation,
          builder: (addMutation, result) {
            return GraphMutationWidget(
              query: updatePartMutation,
              builder: (updateMutation, _) {
                return IconButton(
                  style: IconButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  icon: Icon(Icons.add),
                  onPressed: () async {
                    final result = addMutation({
                      'description': 'New action',
                      'icon': 'hand',
                    });
                    final networkResult = await result.networkResult;
                    final id =
                        networkResult?.data?['addAction']['action'][0]['id'];
                    if (!id.isEmpty) {
                      final part = new Map.from(widget.part);
                      final actions = (part['actions'] as List)
                          .map((a) => {'id': a['id']})
                          .toList();
                      actions.add({'id': id});
                      updateMutation(
                          {'id': widget.part['id'], 'actions': actions});
                    }
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
