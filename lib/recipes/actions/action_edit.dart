import 'package:daily_food_recipe_creator/graphql/mutations/delete_action_mutation.dart';
import 'package:daily_food_recipe_creator/graphql/mutations/delete_part_action_mutation.dart';
import 'package:daily_food_recipe_creator/helpers/confirmation_dialog.dart';
import 'package:daily_food_recipe_creator/recipes/actions/actions_edit.dart';
import 'package:flutter/material.dart';
import 'package:food_icons/food_icons.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../graphql/graph_mutation.dart';
import '../../graphql/mutations/delete_action_action_mutation.dart';
import 'action_description.dart';
import 'action_description_edit.dart';
import 'action_icon_edit.dart';

class ActionEditWidget extends StatefulWidget {
  ActionEditWidget(
      {Key? key, required this.action, required this.parent, this.refetch})
      : super(key: key);

  final dynamic parent;
  final dynamic action;
  final Refetch? refetch;

  @override
  _ActionEditWidgetState createState() => _ActionEditWidgetState();
}

class _ActionEditWidgetState extends State<ActionEditWidget> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> _changes = {};

  @override
  Widget build(BuildContext context) {
    _changes = widget.action;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Form(
          key: _formKey,
          child: Row(
            children: [
              IconButton(
                icon: Icon(_changes['icon'] != null
                    ? FoodIcons.getIcon(_changes['icon'])
                    : Icons.error),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ActionIconEditWidget(
                        action: widget.action,
                        changed: () {
                          widget.refetch!();
                        },
                      );
                    },
                  );
                },
              ),
              TextButton(
                child: ActionDescriptionWidget(action: widget.action),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ActionDescriptionEditWidget(
                        action: widget.action,
                        changed: () {
                          widget.refetch!();
                        },
                      );
                    },
                  );
                },
              ),
              GraphMutationWidget(
                query: widget.parent['title'].toString().isEmpty
                    ? updateActionActionMutation
                    : deletePartActionMutation,
                builder: (removeMutation, _) {
                  return GraphMutationWidget(
                    query: deleteActionMutation,
                    completed: () {
                      Navigator.of(context).pop();
                      widget.refetch!();
                    },
                    builder: (deleteMutation, _) {
                      return IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return ConfirmationDialogWidget(
                                confirmed: () async {
                                  final result = removeMutation({
                                    'id': widget.parent['id'],
                                    'actionId': widget.action['id']
                                  });

                                  final networkResult =
                                      await result.networkResult;
                                  if (networkResult != null &&
                                      networkResult.isConcrete) {
                                    deleteMutation({'id': widget.action['id']});

                                    widget.parent['actions'].removeWhere(
                                        (a) => a['id'] == widget.action['id']);
                                  }
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 50.0),
          child: ActionsEditWidget(
            parent: widget.action,
            actions: widget.action['actions'],
            changed: () => widget.refetch!(),
          ),
        ),
      ],
    );
  }
}
