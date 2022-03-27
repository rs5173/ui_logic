A light state management lib.

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_logic/ui_logic.dart';

void main() {
  testWidgets('ui logic test', (WidgetTester tester) async {
    // init a logic
    final logic = Logic();
    // UIStateBuilder
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
    // test
    await tester.pumpWidget(builder);
  });
}

class UIEventA extends UIEvent {}

class UIEventB extends UIEvent {}

class UIStateA extends UIState {}

class UIStateB extends UIState {}

class UIStateC extends UIState {}

class Logic extends UILogic {
  @override
  void handleUIEvents(UIEvent event, UIState? lastState) {
    if (event is UIEventA) {
      // do sth
    } else if (event is UIEventB) {
      // do sth
    }
    // reply a state to ui
    reply(event, UIStateA());
  }
}
```

