import 'package:flutter/material.dart';
import 'package:todo_app/core/config/index.export.dart';
import 'package:todo_app/data/models/index.export.dart';

class DeleteTodoSnackBar extends SnackBar {
  final TodoSampleLocalizations localizations;

  DeleteTodoSnackBar({
    Key? key,
    required Todo todo,
    required VoidCallback onUndo,
    required this.localizations,
  }) : super(
          key: key,
          content: Text(
            localizations.todoDeleted(todo.task),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          duration: Duration(seconds: 2),
          action: SnackBarAction(
            label: localizations.undo,
            onPressed: onUndo,
          ),
        );
}
