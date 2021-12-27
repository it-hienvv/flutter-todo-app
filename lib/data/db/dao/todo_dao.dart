import 'package:floor/floor.dart';
import '../entity/todo_entity.dart';

@dao
abstract class TodoDao {
  @Query('SELECT * FROM TodoEntity')
  Future<List<TodoEntity>> getAllTodoList();

  @Query('SELECT * FROM TodoEntity WHERE id = :id')
  Future<TodoEntity?> findTodoById(String id);

  @insert
  Future<int> insertTodo(TodoEntity todo);

  @update
  Future<int> updateTodo(TodoEntity todo);

  @delete
  Future<int> deleteTodo(TodoEntity todo);

  @transaction
  Future<int> insertBatch(List<TodoEntity> todos) async {
    int count = 0;
    for (TodoEntity item in todos) {
      await insertTodo(item);
      count += 1;
    }
    return count;
  }

  @transaction
  Future<int> updateBatch(List<TodoEntity> todos) async {
    int count = 0;
    for (TodoEntity item in todos) {
      await updateTodo(item);
      count += 1;
    }
    return count;
  }

  @Query('DELETE FROM TodoEntity')
  Future<void> deleteAllTodo();
}
