import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/index.export.dart';
import 'package:todo_app/presentations/routers/index.export.dart';
import 'package:todo_app/presentations/widgets/widgets.dart';
import 'package:todo_app/core/config/localizations/localization.dart';
import 'package:todo_app/data/models/index.export.dart';
import 'package:todo_app/constants/index.export.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(TodoSampleLocalizations.of(context)!.appTitle),
            actions: [
              FilterButton(visible: activeTab == AppTab.todos),
              ExtraActions(),
            ],
          ),
          body:
              activeTab == AppTab.todos ? const FilteredTodos() : const Stats(),
          floatingActionButton: FloatingActionButton(
            key: TodoSampleKeys.addTodoFab,
            onPressed: () {
              Navigator.pushNamed(context, TodoSampleRoutes.addTodo);
            },
            child: const Icon(Icons.add),
            tooltip: TodoSampleLocalizations.of(context)!.addTodo,
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
          ),
        );
      },
    );
  }
}
