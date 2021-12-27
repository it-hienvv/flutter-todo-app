// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_todo_app.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoDao? _todoDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TodoEntity` (`id` TEXT NOT NULL, `note` TEXT NOT NULL, `task` TEXT NOT NULL, `complete` INTEGER NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _todoEntityInsertionAdapter = InsertionAdapter(
            database,
            'TodoEntity',
            (TodoEntity item) => <String, Object?>{
                  'id': item.id,
                  'note': item.note,
                  'task': item.task,
                  'complete': item.complete ? 1 : 0
                }),
        _todoEntityUpdateAdapter = UpdateAdapter(
            database,
            'TodoEntity',
            ['id'],
            (TodoEntity item) => <String, Object?>{
                  'id': item.id,
                  'note': item.note,
                  'task': item.task,
                  'complete': item.complete ? 1 : 0
                }),
        _todoEntityDeletionAdapter = DeletionAdapter(
            database,
            'TodoEntity',
            ['id'],
            (TodoEntity item) => <String, Object?>{
                  'id': item.id,
                  'note': item.note,
                  'task': item.task,
                  'complete': item.complete ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TodoEntity> _todoEntityInsertionAdapter;

  final UpdateAdapter<TodoEntity> _todoEntityUpdateAdapter;

  final DeletionAdapter<TodoEntity> _todoEntityDeletionAdapter;

  @override
  Future<List<TodoEntity>> getAllTodoList() async {
    return _queryAdapter.queryList('SELECT * FROM TodoEntity',
        mapper: (Map<String, Object?> row) => TodoEntity(
            row['task'] as String,
            row['id'] as String,
            row['note'] as String,
            (row['complete'] as int) != 0));
  }

  @override
  Future<TodoEntity?> findTodoById(String id) async {
    return _queryAdapter.query('SELECT * FROM TodoEntity WHERE id = ?1',
        mapper: (Map<String, Object?> row) => TodoEntity(
            row['task'] as String,
            row['id'] as String,
            row['note'] as String,
            (row['complete'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllTodo() async {
    await _queryAdapter.queryNoReturn('DELETE FROM TodoEntity');
  }

  @override
  Future<int> insertTodo(TodoEntity todo) {
    return _todoEntityInsertionAdapter.insertAndReturnId(
        todo, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateTodo(TodoEntity todo) {
    return _todoEntityUpdateAdapter.updateAndReturnChangedRows(
        todo, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteTodo(TodoEntity todo) {
    return _todoEntityDeletionAdapter.deleteAndReturnChangedRows(todo);
  }

  @override
  Future<int> insertBatch(List<TodoEntity> todos) async {
    if (database is sqflite.Transaction) {
      return super.insertBatch(todos);
    } else {
      return (database as sqflite.Database)
          .transaction<int>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        return transactionDatabase.todoDao.insertBatch(todos);
      });
    }
  }

  @override
  Future<int> updateBatch(List<TodoEntity> todos) async {
    if (database is sqflite.Transaction) {
      return super.updateBatch(todos);
    } else {
      return (database as sqflite.Database)
          .transaction<int>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        return transactionDatabase.todoDao.updateBatch(todos);
      });
    }
  }
}
