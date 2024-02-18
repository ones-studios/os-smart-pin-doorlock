// tab_controller_provider.dart

import 'package:flutter/material.dart';

class TabControllerProvider extends InheritedWidget {
  final TabController tabController;

  const TabControllerProvider({
    Key? key,
    required this.tabController,
    required Widget child,
  }) : super(key: key, child: child);

  static TabControllerProvider of(BuildContext context) {
    final TabControllerProvider? provider =
    context.dependOnInheritedWidgetOfExactType<TabControllerProvider>();
    if (provider == null) {
      throw StateError('No TabControllerProvider found in context');
    }
    return provider;
  }

  @override
  bool updateShouldNotify(covariant TabControllerProvider oldWidget) {
    return tabController != oldWidget.tabController;
  }
}