import 'package:flutter/material.dart';
import 'package:todo_app/core/config/index.export.dart';
import 'package:todo_app/data/models/index.export.dart';
import 'package:todo_app/constants/index.export.dart';
import 'package:todo_app/utils/index.export.dart';

typedef OnSaveCallback = Function(String task, String note);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo? todo;

  const AddEditScreen({
    Key? key,
    required this.onSave,
    required this.isEditing,
    this.todo,
  }) : super(key: key ?? TodoSampleKeys.addTodoScreen);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _task;
  String? _note;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final localizations = TodoSampleLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? localizations!.editTodo : localizations!.addTodo,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.todo!.task : '',
                key: TodoSampleKeys.taskField,
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText: localizations.newTodoHint,
                ),
                validator: (val) {
                  return StringUtils.checkStringIsEmptyOrNull(val)
                      ? localizations.emptyTodoError
                      : null;
                },
                onSaved: (value) => _task = value,
              ),
              TextFormField(
                initialValue: isEditing ? widget.todo!.note : '',
                key: TodoSampleKeys.noteField,
                maxLines: 10,
                style: textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: localizations.notesHint,
                ),
                onSaved: (value) => _note = value,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        key:
            isEditing ? TodoSampleKeys.saveTodoFab : TodoSampleKeys.saveNewTodo,
        tooltip: isEditing ? localizations.saveChanges : localizations.addTodo,
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            widget.onSave(_task!, _note!);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
