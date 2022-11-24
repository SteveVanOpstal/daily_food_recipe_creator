import 'package:daily_food_recipe_creator/graphql/mutations/update_action_mutation.dart';
import 'package:daily_food_recipe_creator/recipes/actions/actions_view.dart';
import 'package:flutter/material.dart';

import '../../graphql/graph_mutation.dart';
import '../../graphql/mutations/add_action_mutation.dart';
import '../../graphql/mutations/update_part_mutation.dart';

class ActionsEditWidget extends StatefulWidget {
  ActionsEditWidget(
      {Key? key, required this.parent, required this.actions, this.changed})
      : super(key: key);

  final dynamic parent;
  final List<dynamic> actions;
  final VoidCallback? changed;

  @override
  _ActionsEditWidgetState createState() => _ActionsEditWidgetState();
}

class _ActionsEditWidgetState extends State<ActionsEditWidget> {
  buildAddActionButton() {
    return GraphMutationWidget(
      query: addActionMutation,
      builder: (addMutation, result) {
        return GraphMutationWidget(
          completed: () {
            if (widget.changed != null) {
              widget.changed!();
            }
          },
          query: widget.parent['title'] == null
              ? updateActionMutation
              : updatePartMutation,
          builder: (updateMutation, _) {
            return ElevatedButton.icon(
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              icon: Icon(Icons.add),
              label: Text('Add action'),
              onPressed: () async {
                final result = addMutation({
                  'description': 'New action',
                  'icon': 'hand',
                });
                final networkResult = await result.networkResult;
                final id = networkResult?.data?['addAction']['action'][0]['id'];
                if (!id.isEmpty) {
                  setState(() {
                    widget.parent['actions']
                        .add({'__typename': 'Action', 'id': id});
                  });
                  final actions = (widget.parent['actions'] as List)
                      .map((a) => {'id': a['id']})
                      .toList();
                  updateMutation(
                      {'id': widget.parent['id'], 'actions': actions});
                }
              },
            );
          },
        );
      },
    );
  }

  //   GraphMutationWidget(
  //     query: addActionMutation,
  //     builder: (addMutation, result) {
  //       return IconButton(
  //         style: IconButton.styleFrom(
  //             backgroundColor: Theme.of(context).primaryColor),
  //         icon: Icon(Icons.add),
  //         onPressed: () {
  //           addMutation({'description': 'New action', 'icon': 'hand'});
  //         },
  //       );
  //     },
  //   ),

  @override
  Widget build(BuildContext context) {
    if (widget.actions.isEmpty) {
      return buildAddActionButton();
    }
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ActionsViewWidget(
            parent: widget.parent,
            actionIds: widget.actions.map((a) => a['id']).toList(),
          ),
          buildAddActionButton(),
        ],
      ),
    );
  }
}
