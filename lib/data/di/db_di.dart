import 'package:get_it/get_it.dart';
import 'package:todo_app/core/config/index.export.dart';
import 'package:todo_app/data/db/index.export.dart';

class DbDI {
  DbDI._();
  static Future<void> init(GetIt injector, BuildMode buildMode) async {
    AppDatabase database = await $FloorAppDatabase
        .databaseBuilder('${buildMode.toString()}_todo_app.db')
        .build();
    injector.registerSingleton<AppDatabase>(database);
  }
}
