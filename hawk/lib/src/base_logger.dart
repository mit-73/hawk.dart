import 'dart:developer' show log;

import 'logger.dart';

class BaseLogger implements ILogger {
  const BaseLogger({this.isDebug = false});

  static const String tag = 'HawkCatcher';
  static const String warning = 'WARNING';

  final bool isDebug;

  @override
  void e(String message, [Object? error, StackTrace? stackTrace]) {
    log(
      message,
      name: tag,
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }

  @override
  void i(String message) {
    if (isDebug) {
      log(
        message,
        name: tag,
        level: 800,
      );
    }
  }

  @override
  void w(String message) {
    log(
      '[$warning] $message',
      name: tag,
      level: 900,
    );
  }
}
