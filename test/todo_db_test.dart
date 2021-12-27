import 'package:test/test.dart';
import 'package:todo_app/core/config/index.export.dart';
import 'package:todo_app/data/db/index.export.dart';
import 'package:todo_app/data/di/injector.dart';
import 'package:todo_app/data/repo/index.export.dart';
import 'package:todo_app/utils/index.export.dart';

void main() async {
  await AppConfig().configApp(BuildMode.test);
  group('Todo DB test ->', () {
    final AppDatabase dbDao =
        AppInjector.injector<TodosRepositoryFlutter>().dbDao;
    final itemAdd = TodoEntity(
      'Add new item',
      Uuid().generateV4(),
      'with item!',
      false,
    );
    setUpAll(() async {
      await dbDao.todoDao.deleteAllTodo();
    });
    List<TodoEntity> todos = [
      TodoEntity(
        'Buy food for dog',
        Uuid().generateV4(),
        'With the chicken!',
        false,
      ),
      TodoEntity(
        'Buy tea',
        Uuid().generateV4(),
        'China tea',
        false,
      ),
      TodoEntity(
        'Book milk',
        Uuid().generateV4(),
        'With chicken',
        true,
      ),
      TodoEntity(
        'Play game',
        Uuid().generateV4(),
        'With friend',
        false,
      ),
      TodoEntity(
        'Shopping',
        Uuid().generateV4(),
        'on the moon',
        true,
      ),
    ];
    test('Must be inserted 1 item in DB', () async {
      int count = await dbDao.todoDao.insertTodo(itemAdd);
      expect(count, 1);
    });
    test('Must be inserted batch ${todos.length} in DB', () async {
      int count = await dbDao.todoDao.insertBatch(todos);
      expect(count, todos.length);
    });

    test('Must be update batch ${todos.length} in DB', () async {
      final lst =
          todos.map((e) => e.copyWith(task: "Task update batch")).toList();
      int count = await dbDao.todoDao.updateBatch(lst);
      expect(count, lst.length);
    });
    test('Must be updated 1 item in DB', () async {
      int count = await dbDao.todoDao
          .updateTodo(todos[0].copyWith(task: "Task updated"));
      expect(count, 1);
    });

    test('Must be deleted 1 item in DB', () async {
      int count = await dbDao.todoDao.deleteTodo(itemAdd);
      expect(count, 1);
    });

    test('Must be deleted all  item in DB', () async {
      await dbDao.todoDao.deleteAllTodo();
      List<TodoEntity> lst = await dbDao.todoDao.getAllTodoList();
      expect(lst.length, 0);
    });
  });
}
