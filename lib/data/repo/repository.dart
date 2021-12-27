import 'dart:async';
import 'dart:core';
import 'package:todo_app/data/db/index.export.dart';
import 'package:todo_app/utils/index.export.dart';

class TodosRepositoryFlutter implements TodoDao {
  final AppDatabase dbDao;

  const TodosRepositoryFlutter({
    required this.dbDao,
  });
  @override
  Future<List<TodoEntity>> getAllTodoList() async {
    List<TodoEntity> todos = [];
    try {
      await mockData();
      todos = await dbDao.todoDao.getAllTodoList();
    } catch (e) {
      return [];
    }
    return todos;
  }

  @override
  Future<int> deleteTodo(TodoEntity todo) {
    return dbDao.todoDao.deleteTodo(todo);
  }

  @override
  Future<int> updateTodo(TodoEntity todo) {
    return dbDao.todoDao.updateTodo(todo);
  }

  @override
  Future<int> insertTodo(TodoEntity todo) {
    return dbDao.todoDao.insertTodo(todo);
  }

  @override
  Future<int> insertBatch(List<TodoEntity> todos) {
    return dbDao.todoDao.insertBatch(todos);
  }

  @override
  Future<int> updateBatch(List<TodoEntity> todos) {
    return dbDao.todoDao.updateBatch(todos);
  }

  @override
  Future<TodoEntity?> findTodoById(String id) {
    return dbDao.todoDao.findTodoById(id);
  }

  Future<void> mockData() async {
    final lstTodos = await dbDao.todoDao.getAllTodoList();
    if (lstTodos.isNotEmpty) {
      return;
    }
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
    await dbDao.todoDao.insertBatch(todos);
  }

  @override
  Future<void> deleteAllTodo() {
    return dbDao.todoDao.deleteAllTodo();
  }
}
