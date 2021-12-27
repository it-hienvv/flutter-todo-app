import 'package:get_it/get_it.dart';
import 'package:todo_app/core/config/index.export.dart';
import 'package:todo_app/data/repo/index.export.dart';

class ServiceDI {
  ServiceDI._();

  static Future<void> init(GetIt injector, BuildMode buildMode) async {
    injector.registerSingleton<TodosRepositoryFlutter>(
        TodosRepositoryFlutter(dbDao: injector()));
  }
}
