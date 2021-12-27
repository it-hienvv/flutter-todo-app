import 'package:flutter/material.dart';

class TodoSampleTheme {
  static get theme {
    final originalTextTheme = ThemeData.dark().textTheme;
    final originalBody1 = originalTextTheme.bodyText1;

    return ThemeData.dark().copyWith(
        primaryColor: Colors.grey[800],
        backgroundColor: Colors.grey[800],
        toggleableActiveColor: Colors.cyan[300],
        textTheme: originalTextTheme.copyWith(
            bodyText1:
                originalBody1!.copyWith(decorationColor: Colors.transparent)));
  }
}
