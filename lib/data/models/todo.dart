import 'package:equatable/equatable.dart';
import 'package:todo_app/data/db/entity/todo_entity.dart';
import 'package:todo_app/utils/index.export.dart';

class Todo extends Equatable {
  final bool complete;
  final String id;
  final String note;
  final String task;

  Todo(
    this.task, {
    this.complete = false,
    String? note = '',
    String? id,
  })  : note = note ?? '',
        id = id ?? Uuid().generateV4();

  Todo copyWith({bool? complete, String? id, String? note, String? task}) {
    return Todo(
      task ?? this.task,
      complete: complete ?? this.complete,
      id: id ?? this.id,
      note: note ?? this.note,
    );
  }

  @override
  List<Object> get props => [complete, id, note, task];

  @override
  String toString() {
    return 'Todo { complete: $complete, task: $task, note: $note, id: $id }';
  }

  TodoEntity toEntity() {
    return TodoEntity(task, id, note, complete);
  }

  static Todo fromEntity(TodoEntity entity) {
    return Todo(
      entity.task,
      complete: entity.complete,
      note: entity.note,
      id: entity.id,
    );
  }
}
