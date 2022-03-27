import 'package:flutter/widgets.dart';
import 'package:ui_logic/src/state_cache.dart';
import 'package:ui_logic/src/logic.dart';
import 'package:ui_logic/src/state.dart';

/// A Listener use to check UI state changes
///
typedef UIStateWidgetBuilder = Widget Function(BuildContext context, UIState state);

/// UIStateObserver widget
///
class UIStateBuilder extends StatelessWidget {
  UIStateBuilder({
    Key? key,
    required this.logic,
    required this.states,
    required this.builder,
  }) : super(key: key) {
    UIStateCache().addStateNotifier(logic, states, stateNotifier);
  }

  /// Host [UILogic]
  ///
  final UILogic logic;

  /// All UI States you expected
  ///
  final List<Type> states;

  /// UIStateWidgetBuilder
  ///
  final UIStateWidgetBuilder builder;

  /// stateNotifier
  ///
  final stateNotifier = ValueNotifier<UIState>(InvalidUIState());

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UIState>(
      valueListenable: stateNotifier,
      builder: (context, state, _) => builder(context, state),
    );
  }
}
