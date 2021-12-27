import 'package:test/test.dart';
import 'package:todo_app/core/config/index.export.dart';
import 'package:todo_app/blocs/index.export.dart';
import 'package:todo_app/data/db/index.export.dart';
import 'package:todo_app/data/di/injector.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo_app/data/models/index.export.dart';
import 'package:todo_app/data/repo/index.export.dart';
import 'package:collection/collection.dart';

void main() async {
  await AppConfig().configApp(BuildMode.test);
  group('Todo bloc ->', () {
    setUpAll(() async {
      await AppInjector.injector<TodosRepositoryFlutter>()
          .dbDao
          .todoDao
          .deleteAllTodo();
      await AppInjector.injector<TodosRepositoryFlutter>().mockData();
      await Future.delayed(const Duration(milliseconds: 3000));
    });
    late TodosBloc todoBlocs;
    Todo itemAdd = Todo('Thêm nhiệm vụ mới', note: 'Ghi chú');
    String taskNameUpdate = "Update name";
    blocTest<TodosBloc, TodosState>(
      'with Bloc test -> First load success',
      build: () {
        return todoBlocs;
      },
      act: (bloc) {
        bloc.add(TodosLoaded());
        return bloc;
      },
      expect: () {
        return [isA<TodosLoadSuccess>()];
      },
      setUp: () =>
          todoBlocs = TodosBloc(todosRepository: AppInjector.injector()),
    );
    test(
        'Must be equals length in DB and Bloc item inserted after load success',
        () async {
      final todos =
          await AppInjector.injector<TodosRepositoryFlutter>().getAllTodoList();
      final state = todoBlocs.state as TodosLoadSuccess;
      expect(state.todos.length, todos.length);
    });
    blocTest<TodosBloc, TodosState>(
      'with Bloc test -> When add new Todo item success',
      build: () {
        return todoBlocs;
      },
      act: (bloc) {
        bloc.add(TodosLoaded());
        bloc.add(TodoAdded(itemAdd));
        return bloc;
      },
      expect: () {
        return [isA<TodosLoadSuccess>(), isA<TodosLoadSuccess>()];
      },
      setUp: () =>
          todoBlocs = TodosBloc(todosRepository: AppInjector.injector()),
    );
    test('Must be exist item added in DB and Blocs', () async {
      final todoInDB = await AppInjector.injector<TodosRepositoryFlutter>()
          .findTodoById(itemAdd.id);
      final state = todoBlocs.state as TodosLoadSuccess;
      final todoInBloc =
          state.todos.firstWhere((item) => item.id == todoInDB!.id);
      bool isSame = todoInBloc.id == todoInDB!.id;
      expect(isSame, true);
    });

    blocTest<TodosBloc, TodosState>(
      'with Bloc test -> When Update Todo item success',
      build: () {
        return todoBlocs;
      },
      act: (bloc) {
        bloc.add(TodosLoaded());
        bloc.add(TodoUpdated(itemAdd.copyWith(task: taskNameUpdate)));
        return bloc;
      },
      expect: () {
        return [isA<TodosLoadSuccess>(), isA<TodosLoadSuccess>()];
      },
      setUp: () =>
          todoBlocs = TodosBloc(todosRepository: AppInjector.injector()),
    );

    test('Must be item updated equals name in DB and Bloc', () async {
      final todoInDB = await AppInjector.injector<TodosRepositoryFlutter>()
          .findTodoById(itemAdd.id);
      final state = todoBlocs.state as TodosLoadSuccess;
      final todoInBloc =
          state.todos.firstWhere((item) => item.id == todoInDB!.id);
      bool isSameTaskName = todoInBloc.task == todoInDB!.task;
      expect(isSameTaskName, true);
    });

    blocTest<TodosBloc, TodosState>(
        'with Bloc test -> When delete Todo item success',
        build: () {
          return todoBlocs;
        },
        act: (bloc) {
          bloc.add(TodosLoaded());
          bloc.add(TodoDeleted(itemAdd));
          return bloc;
        },
        expect: () {
          return [
            isA<TodosLoadSuccess>(),
            isA<TodosLoadSuccess>(),
          ];
        },
        setUp: () => {
              todoBlocs = TodosBloc(todosRepository: AppInjector.injector()),
            });
    test('Must be item deleted in DB and Bloc', () async {
      TodoEntity? todoInDB =
          await AppInjector.injector<TodosRepositoryFlutter>()
              .findTodoById(itemAdd.id);
      final state = todoBlocs.state as TodosLoadSuccess;
      Todo? todoInBloc =
          state.todos.firstWhereOrNull((item) => item.id == itemAdd.id);
      bool isSameNull = todoInBloc == null && todoInDB == null;
      expect(isSameNull, true);
    });

    blocTest<TodosBloc, TodosState>(
        'with Bloc test -> When Toggle All Todo item success',
        build: () {
          return todoBlocs;
        },
        act: (bloc) {
          bloc.add(TodosLoaded());
          bloc.add(ToggleAll());
          return bloc;
        },
        expect: () {
          return [
            isA<TodosLoadSuccess>(),
            isA<TodosLoadSuccess>(),
          ];
        },
        setUp: () => {
              todoBlocs = TodosBloc(todosRepository: AppInjector.injector()),
            });

    blocTest<TodosBloc, TodosState>(
        'with Bloc test -> When ClearCompleted all Todo item success',
        build: () {
          return todoBlocs;
        },
        act: (bloc) {
          bloc.add(TodosLoaded());
          bloc.add(ClearCompleted());
          return bloc;
        },
        expect: () {
          return [
            isA<TodosLoadSuccess>(),
            isA<TodosLoadSuccess>(),
          ];
        },
        setUp: () => {
              todoBlocs = TodosBloc(todosRepository: AppInjector.injector()),
            });
  });
}
