import 'package:daily_food_recipe_creator/recipes/actions/actions_edit.dart';
import 'package:daily_food_recipe_creator/recipes/parts/part_title_edit.dart';
import 'package:flutter/material.dart';

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
      ],
    );
  }
}
