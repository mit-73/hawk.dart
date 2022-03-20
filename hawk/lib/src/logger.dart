abstract class ILogger {
  /// Show error messages
  void e(String message, [Object? error, StackTrace? stackTrace]);

  /// Show additional information
  void i(String message);

  /// Show warning messages
  void w(String message);
}
