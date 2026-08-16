import 'package:flutter/material.dart';

import '../controllers/app_settings.dart';
import '../controllers/planner_store.dart';

/// Exposes the app-wide [AppSettings] and [PlannerStore] down the tree.
class AppScope extends InheritedWidget {
  final AppSettings settings;
  final PlannerStore store;

  const AppScope({
    super.key,
    required this.settings,
    required this.store,
    required super.child,
  });

  static AppScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppScope>();
    assert(scope != null, 'AppScope not found — screen pushed outside the app tree');
    return scope!;
  }

  @override
  bool updateShouldNotify(AppScope oldWidget) =>
      oldWidget.settings != settings || oldWidget.store != store;
}
