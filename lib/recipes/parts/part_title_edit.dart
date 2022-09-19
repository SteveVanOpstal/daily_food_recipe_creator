import 'package:flutter/material.dart';

import '../../graphql/mutations/update_part_mutation.dart';
import '../../graphql/mutation_dialog.dart';

class PartTitleEditWidget extends MutationDialogWidget {
  PartTitleEditWidget({Key? key, this.part, required this.changed})
      : super(
            key: key,
            changed: changed,
            query: updatePartMutation,
            subject: part,
            subjectKey: 'title',
            validator: (value) => value!.isEmpty ? 'empty' : null);

  final dynamic part;
  final Function changed;
}
