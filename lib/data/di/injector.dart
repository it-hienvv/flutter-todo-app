import 'package:get_it/get_it.dart';
import 'package:todo_app/core/config/index.export.dart';
import 'bloc_di.dart';
import 'service_di.dart';
import 'db_di.dart';

class AppInjector {
  AppInjector._();

  static final injector = GetIt.instance;

  static Future<void> initializeDependencies(
      {required BuildMode buildMode}) async {
    await DbDI.init(injector, buildMode);
    await ServiceDI.init(injector, buildMode);
    await BlocDI.init(injector, buildMode);
  }
}
