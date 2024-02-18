// provider.dart

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider extends InheritedWidget {
  final Database database;

  const DatabaseProvider({
    Key? key,
    required this.database,
    required Widget child,
  }) : super(key: key, child: child);

  static DatabaseProvider of(BuildContext context) {
    final DatabaseProvider? provider =
    context.dependOnInheritedWidgetOfExactType<DatabaseProvider>();
    if (provider == null) {
      throw StateError('No DatabaseProvider found in context');
    }
    return provider;
  }

  @override
  bool updateShouldNotify(covariant DatabaseProvider oldWidget) {
    return database != oldWidget.database;
  }
}
