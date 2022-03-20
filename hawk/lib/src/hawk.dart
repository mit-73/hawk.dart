import 'dart:async';

import 'hawk_catcher.dart';
import 'throwable.dart';

typedef AppRunner = void Function();

class Hawk {
  Hawk._();

  static HawkCatcher? _catcher;
  static HawkCatcher? get currnetCatcher => _catcher;

  static void init(AppRunner body, HawkOptions options) {
    _catcher = HawkCatcher(hawkOptions: options);

    runZonedGuarded(
      body,
      (Object error, StackTrace stackTrace) {
        _catcher?.caught(Throwable(error: error, stackTrace: stackTrace));
      },
    );
  }

  static void close() {
    _catcher = null;
  }

  static bool get isEnabled => _catcher != null;
}
