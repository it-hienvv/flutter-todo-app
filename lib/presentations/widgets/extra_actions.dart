import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/todos/index.export.dart';
import 'package:todo_app/data/models/index.export.dart';
import 'package:todo_app/constants/index.export.dart';
import 'package:todo_app/core/config/index.export.dart';

class ExtraActions extends StatelessWidget {
  ExtraActions({Key? key}) : super(key: TodoSampleKeys.extraActionsButton);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodosBloc, TodosState>(
      builder: (context, state) {
        if (state is TodosLoadSuccess) {
          bool allComplete =
              (BlocProvider.of<TodosBloc>(context).state as TodosLoadSuccess)
                  .todos
                  .every((todo) => todo.complete);
          return PopupMenuButton<ExtraAction>(
            key: FlutterTodosKeys.extraActionsPopupMenuButton,
            onSelected: (action) {
              switch (action) {
                case ExtraAction.clearCompleted:
                  BlocProvider.of<TodosBloc>(context).add(ClearCompleted());
                  break;
                case ExtraAction.toggleAllComplete:
                  BlocProvider.of<TodosBloc>(context).add(ToggleAll());
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuItem<ExtraAction>>[
              PopupMenuItem<ExtraAction>(
                key: TodoSampleKeys.toggleAll,
                value: ExtraAction.toggleAllComplete,
                child: Text(
                  allComplete
                      ? TodoSampleLocalizations.of(context)!.markAllIncomplete
                      : TodoSampleLocalizations.of(context)!.markAllComplete,
                ),
              ),
              PopupMenuItem<ExtraAction>(
                key: TodoSampleKeys.clearCompleted,
                value: ExtraAction.clearCompleted,
                child: Text(
                  TodoSampleLocalizations.of(context)!.clearCompleted,
                ),
              ),
            ],
          );
        }
        return Container(key: FlutterTodosKeys.extraActionsEmptyContainer);
      },
    );
  }
}
