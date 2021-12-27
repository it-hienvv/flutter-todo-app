import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/index.export.dart';
import 'package:todo_app/constants/index.export.dart';
import 'package:todo_app/core/config/index.export.dart';
import 'package:todo_app/core/themes/index.export.dart';
import 'package:todo_app/data/di/index.exports.dart';
import 'package:todo_app/data/models/index.export.dart';
import 'package:todo_app/presentations/routers/index.export.dart';
import 'package:todo_app/presentations/screens/index.export.dart';

class TodosApp extends StatelessWidget {
  const TodosApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter to do app",
      theme: TodoSampleTheme.theme,
      localizationsDelegates: [
        TodoSampleLocalizationsDelegate(),
      ],
      routes: {
        TodoSampleRoutes.home: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<TabBloc>(
                create: (context) => AppInjector.injector<TabBloc>(),
              ),
              BlocProvider<FilteredTodosBloc>(
                create: (context) => AppInjector.injector<FilteredTodosBloc>(),
              ),
              BlocProvider<StatsBloc>(
                create: (context) => AppInjector.injector<StatsBloc>(),
              ),
            ],
            child: const HomeScreen(),
          );
        },
        TodoSampleRoutes.addTodo: (context) {
          return AddEditScreen(
            key: TodoSampleKeys.addTodoScreen,
            onSave: (task, note) {
              BlocProvider.of<TodosBloc>(context).add(
                TodoAdded(Todo(task, note: note)),
              );
            },
            isEditing: false,
          );
        },
      },
    );
  }
}
