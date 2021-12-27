import 'package:test/test.dart';
import 'package:todo_app/core/config/index.export.dart';
import 'package:todo_app/blocs/index.export.dart';
import 'package:todo_app/data/di/injector.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo_app/data/repo/index.export.dart';

void main() async {
  await AppConfig().configApp(BuildMode.test);
  group('Stats bloc ->', () {
    setUpAll(() async {
      await AppInjector.injector<TodosRepositoryFlutter>()
          .dbDao
          .todoDao
          .deleteAllTodo();
      await AppInjector.injector<TodosRepositoryFlutter>().mockData();
    });
    TodosBloc todoBlocs = AppInjector.injector<TodosBloc>();
    todoBlocs.add(TodosLoaded());
    blocTest<StatsBloc, StatsState>(
      'with Stats test -> First load success',
      build: () {
        return AppInjector.injector<StatsBloc>();
      },
      act: (bloc) {
        return bloc;
      },
      expect: () {
        prints(todoBlocs);
        return [isA<StatsLoadSuccess>()];
      },
    );
  });
}
