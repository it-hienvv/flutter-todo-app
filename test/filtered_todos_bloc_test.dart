import 'package:test/test.dart';
import 'package:todo_app/core/config/index.export.dart';
import 'package:todo_app/blocs/index.export.dart';
import 'package:todo_app/data/di/injector.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo_app/data/models/index.export.dart';
import 'package:todo_app/data/repo/index.export.dart';

void main() async {
  await AppConfig().configApp(BuildMode.test);
  group('Filtered bloc ->', () {
    setUpAll(() async {
      await AppInjector.injector<TodosRepositoryFlutter>()
          .dbDao
          .todoDao
          .deleteAllTodo();
      await AppInjector.injector<TodosRepositoryFlutter>().mockData();
    });
    TodosBloc todoBlocs = AppInjector.injector<TodosBloc>();
    blocTest<FilteredTodosBloc, FilteredTodosState>(
      'with Filtered test -> First load success',
      build: () {
        return AppInjector.injector<FilteredTodosBloc>();
      },
      act: (bloc) {
        todoBlocs.add(TodosLoaded());
        return pumpEventQueue();
      },
      expect: () {
        return [isA<FilteredTodosLoadSuccess>()];
      },
    );

    blocTest<FilteredTodosBloc, FilteredTodosState>(
      'with Filtered test -> Action filter show all',
      build: () {
        return AppInjector.injector<FilteredTodosBloc>();
      },
      act: (bloc) {
        bloc.add(const FilterUpdated(VisibilityFilter.all));
        return bloc;
      },
      expect: () {
        return [isA<FilteredTodosLoadSuccess>()];
      },
    );

    blocTest<FilteredTodosBloc, FilteredTodosState>(
      'with Filtered test -> Action filter show active',
      build: () {
        return AppInjector.injector<FilteredTodosBloc>();
      },
      act: (bloc) {
        bloc.add(const FilterUpdated(VisibilityFilter.active));
        return bloc;
      },
      expect: () {
        return [isA<FilteredTodosLoadSuccess>()];
      },
    );

    blocTest<FilteredTodosBloc, FilteredTodosState>(
      'with Filtered test -> Action filter show completed',
      build: () {
        return AppInjector.injector<FilteredTodosBloc>();
      },
      act: (bloc) {
        bloc.add(const FilterUpdated(VisibilityFilter.completed));
        return bloc;
      },
      expect: () {
        return [isA<FilteredTodosLoadSuccess>()];
      },
    );
  });
}
