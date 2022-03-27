import 'package:flutter/foundation.dart';
import 'package:ui_logic/src/event.dart';
import 'package:ui_logic/src/logic.dart';
import 'package:ui_logic/src/state.dart';

/// Use to cache all UI state and State-ValueNotifier.
///
class UIStateCache {
  static final UIStateCache _singleton = UIStateCache._internal();

  factory UIStateCache() => _singleton;

  UIStateCache._internal();

  final _logicStateCache = <UILogic, Map<Type, UIState>>{};
  final _logicStateNotifierCache = <UILogic, Map<Type, List<ValueNotifier>>>{};

  /// add a stateNotifier
  ///
  void addStateNotifier(UILogic logic, List<Type> states, ValueNotifier stateNotifier) {
    if (_logicStateNotifierCache.containsKey(logic)) {
      final stateNotifierCache = _logicStateNotifierCache[logic]!;
      for (final state in states) {
        if (stateNotifierCache.containsKey(state)) {
          final stateNotifiers = stateNotifierCache[state]!;
          stateNotifiers.add(stateNotifier);
        } else {
          final stateNotifiers = <ValueNotifier>[];
          stateNotifiers.add(stateNotifier);
          stateNotifierCache[state] = stateNotifiers;
        }
      }
    } else {
      final stateNotifierCache = <Type, List<ValueNotifier>>{};
      for (final state in states) {
        stateNotifierCache[state] = [stateNotifier];
      }
      _logicStateNotifierCache[logic] = stateNotifierCache;
    }
  }

  /// get a state from cache
  ///
  UIState? getUIState(UILogic logic, UIEvent event) {
    final stateCache = _logicStateCache[logic];
    return stateCache?[event.runtimeType];
  }

  /// cache a state
  ///
  void addUIState(UILogic logic, UIEvent event, UIState state) {
    if (!_logicStateCache.containsKey(logic)) {
      _logicStateCache[logic] = <Type, UIState>{};
    }
    final stateCache = _logicStateCache[logic];
    stateCache?[event.runtimeType] = state;
  }

  /// reply a state to ui
  ///
  void replyUIState(UILogic logic, UIState state) {
    final stateNotifierCache = _logicStateNotifierCache[logic];
    final stateNotifiers = stateNotifierCache?[state.runtimeType];
    stateNotifiers?.forEach((stateNotifier) => stateNotifier.value = state);
  }

  /// clear all state and stateNotifier
  ///
  void clear(UILogic logic) {
    final stateCache = _logicStateCache[logic];
    final stateNotifierCache = _logicStateNotifierCache[logic];
    stateCache?.clear();
    stateNotifierCache?.forEach((state, stateNotifier) => stateNotifier.clear());
    stateNotifierCache?.clear();
    _logicStateCache.remove(logic);
    _logicStateNotifierCache.remove(logic);
  }
}
