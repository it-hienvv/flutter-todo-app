import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/index.export.dart';
import 'package:todo_app/core/config/index.export.dart';
import 'package:todo_app/data/di/index.exports.dart';
import 'package:todo_app/presentations/screens/index.export.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig().configApp(BuildMode.dev);
  Bloc.observer = SimpleBlocObserver();
  runApp(
    BlocProvider(
      create: (context) {
        return AppInjector.injector<TodosBloc>()..add(TodosLoaded());
      },
      child: const TodosApp(),
    ),
  );
}
