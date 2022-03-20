import 'package:stack_trace/stack_trace.dart';

class Throwable {
  Throwable({
    required this.error,
    StackTrace? stackTrace,
  }) : chain = stackTrace != null ? Chain.forTrace(stackTrace) : null;

  static Never throwThrowable(Object error, StackTrace stackTrace) {
    throw Error.throwWithStackTrace(
      Throwable(error: error, stackTrace: stackTrace),
      stackTrace,
    );
  }

  final Object error;
  final Chain? chain;

  String get message => Error.safeToString(error);
  String get type => error.runtimeType.toString();
}
