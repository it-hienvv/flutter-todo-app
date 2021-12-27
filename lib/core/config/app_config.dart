import 'package:todo_app/core/config/index.export.dart';
import 'package:todo_app/data/di/index.exports.dart';

class AppConfig {
  static final AppConfig _appConfig = AppConfig._();
  factory AppConfig() {
    return _appConfig;
  }
  AppConfig._();

  Future<void> configApp(BuildMode buidmode) async {
    await AppInjector.initializeDependencies(buildMode: buidmode);
  }
}
