import 'package:daily_food_recipe_creator/graphql/mutations/update_recipe_mutation.dart';
import 'package:daily_food_recipe_creator/recipes/parts/part.dart';
import 'package:flutter/material.dart';

import '../../graphql/graph_mutation.dart';
import '../../graphql/mutations/add_part_mutation.dart';

class PartsWidget extends StatefulWidget {
  PartsWidget({Key? key, required this.recipe}) : super(key: key);

  final dynamic recipe;

  @override
  _PartsWidgetState createState() => _PartsWidgetState();
}

class _PartsWidgetState extends State<PartsWidget> {
  buildAddPartButton() {
    return GraphMutationWidget(
      query: addPartMutation,
      builder: (addMutation, result) {
        return GraphMutationWidget(
          completed: () {
            // if (widget.changed != null) {
            //   widget.changed!();
            // }
          },
          query: updateRecipeMutation,
          builder: (updateMutation, _) {
            return ElevatedButton.icon(
              style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
              ),
              icon: Icon(Icons.add),
              label: Text('Add part'),
              onPressed: () async {
                final result = addMutation({
                  'title': 'New Part',
                });
                final networkResult = await result.networkResult;
                final id = networkResult?.data?['addPart']['part'][0]['id'];
                if (!id.isEmpty) {
                  setState(() {
                    widget.recipe['parts']
                        .add({'__typename': 'Part', 'id': id});
                  });
                  final parts = (widget.recipe['parts'] as List)
                      .map((a) => {'id': a['id']})
                      .toList();
                  updateMutation({
                    'id': widget.recipe['id'],
                    'parts': parts,
                  });
                }
              },
            );
          },
        );
      },
    );
  }

  // buildPartButton(dynamic part) {
  //   var actions = part['actions'] as List<dynamic>;
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(part['title']),
  //       ActionsViewWidget(
  //         parent: part,
  //         actionIds: actions.map((a) => a['id']).toList(),
  //         inverse: true,
  //       )
  //     ],
  //   );
  // }

  buildParts(List<dynamic> parts) {
    var recipeParts = [];
    for (var part in parts) {
      recipeParts.add(PartWidget(recipe: widget.recipe, part: part));
    }
    return recipeParts;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.recipe['parts'] == null) {
      return buildAddPartButton();
    }
    return Column(
      children: [
        ...buildParts(widget.recipe['parts']),
        buildAddPartButton(),
      ],
    );
  }
}
