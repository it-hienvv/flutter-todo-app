import 'package:flutter/material.dart';
import 'package:todo_app/data/models/index.export.dart';
import 'package:todo_app/core/config/index.export.dart';
import 'package:todo_app/constants/index.export.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  const TabSelector({
    Key? key,
    required this.activeTab,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: TodoSampleKeys.tabs,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.todos ? Icons.list : Icons.show_chart,
            key: tab == AppTab.todos
                ? TodoSampleKeys.todoTab
                : TodoSampleKeys.statsTab,
          ),
          label: tab == AppTab.stats
              ? TodoSampleLocalizations.of(context)!.stats
              : TodoSampleLocalizations.of(context)!.todos,
        );
      }).toList(),
    );
  }
}
