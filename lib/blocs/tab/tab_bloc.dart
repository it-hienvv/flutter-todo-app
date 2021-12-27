import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:todo_app/blocs/tab/index.export.dart';
import 'package:todo_app/data/models/index.export.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.todos);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}
