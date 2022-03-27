// This is a basic Flutter components test.
//
// To perform an interaction with a components in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the components
// tree, read text, and verify that the values of components properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_logic/ui_logic.dart';

void main() {
  testWidgets('ui logic test', (WidgetTester tester) async {
    final logic = Logic();

    final builder = UIStateBuilder(
      logic: logic,
      states: const [UIStateA, UIStateB, UIStateC],
      builder: (context, state) {
        if (state is UIStateA) {
          // do sth
        } else if (state is UIStateB) {
          // do sth
        } else if (state is UIStateC) {
          // do sth
        }
        return const SizedBox();
      },
    );

    // emit a ui event
    logic.emit(UIEventA());

    // Build our app and trigger a frame.
    await tester.pumpWidget(builder);
  });
}

class UIEventA extends UIEvent {}

class UIStateA extends UIState {}

class UIStateB extends UIState {}

class UIStateC extends UIState {}

class Logic extends UILogic {
  @override
  void handleUIEvents(UIEvent event, UIState? lastState) {
    reply(event, UIStateA());
  }
}
