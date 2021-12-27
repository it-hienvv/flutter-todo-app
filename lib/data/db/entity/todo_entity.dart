import 'package:floor/floor.dart';

@entity
class TodoEntity {
  @primaryKey
  final String id;
  final String note;
  final String task;
  final bool complete;

  TodoEntity(this.task, this.id, this.note, this.complete);

  @override
  int get hashCode =>
      complete.hashCode ^ task.hashCode ^ note.hashCode ^ id.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoEntity &&
          runtimeType == other.runtimeType &&
          complete == other.complete &&
          task == other.task &&
          note == other.note &&
          id == other.id;

  Map<String, Object> toJson() {
    return {
      "complete": complete,
      "task": task,
      "note": note,
      "id": id,
    };
  }

  @override
  String toString() {
    return 'TodoEntity{complete: $complete, task: $task, note: $note, id: $id}';
  }

  static TodoEntity fromJson(Map<String, Object> json) {
    return TodoEntity(
      json["task"] as String,
      json["id"] as String,
      json["note"] as String,
      json["complete"] as bool,
    );
  }

  TodoEntity copyWith(
      {bool? complete, String? id, String? note, String? task}) {
    return TodoEntity(
      task ?? this.task,
      id ?? this.id,
      note ?? this.note,
      complete ?? this.complete,
    );
  }
}
