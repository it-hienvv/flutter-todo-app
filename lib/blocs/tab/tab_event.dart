import 'package:equatable/equatable.dart';
import 'package:todo_app/data/models/index.export.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();
}

class TabUpdated extends TabEvent {
  final AppTab tab;

  const TabUpdated(this.tab);

  @override
  List<Object> get props => [tab];

  @override
  String toString() => 'TabUpdated { tab: $tab }';
}
