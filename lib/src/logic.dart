import 'package:ui_logic/src/state_cache.dart';
import 'package:ui_logic/src/event.dart';
import 'package:ui_logic/src/state.dart';

/// Logic layer, responsible for handling all UI logic.
///
/// NOTES: You should divide a complex UI into several parts,
/// each part should have its own logic
abstract class UILogic {
  /// use to cache all state and reply state to UI layer.
  ///
  final _stateCache = UIStateCache();

  /// Emit a UI event.
  ///
  /// [event] A new event.
  void emit(UIEvent event) {
    final lastState = _stateCache.getUIState(this, event);
    handleUIEvents(event, lastState);
  }

  /// Reply a new UI state
  ///
  /// [event] The event corresponding to new state.
  /// [state] A new UI state.
  void reply(UIEvent event, UIState state) {
    _stateCache.addUIState(this, event, state);
    _stateCache.replyUIState(this, state);
  }

  /// Handle all UI events , and you can call [reply] method
  /// to return a UI state
  ///
  /// [event] A UI event.
  /// [lastState] Last UI state corresponding to current event.
  void handleUIEvents(UIEvent event, UIState? lastState);

  /// Destroy this logic, and you should release all resources
  /// in the current Logic.
  ///
  void destroy() {
    _stateCache.clear(this);
  }
}
