import 'package:get_it/get_it.dart';
import 'package:todo_app/blocs/index.export.dart';
import 'package:todo_app/core/config/index.export.dart';

class BlocDI {
  BlocDI._();
  static Future<void> init(GetIt injector, BuildMode buildMode) async {
    injector
        .registerSingleton<TodosBloc>(TodosBloc(todosRepository: injector()));
    injector.registerFactory<TabBloc>(() => TabBloc());
    injector.registerFactory<FilteredTodosBloc>(
        () => FilteredTodosBloc(todosBloc: injector()));
    injector.registerFactory<StatsBloc>(() => StatsBloc(todosBloc: injector()));
  }
}
