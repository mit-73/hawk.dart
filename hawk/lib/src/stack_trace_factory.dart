import 'package:meta/meta.dart';
import 'package:stack_trace/stack_trace.dart';

import 'hawk_event.dart' show Backtrace, SourceCode;

/// converts [StackTrace] to [Backtrace]
class StackTraceFactory {
  static const String _stackTraceViolateDartStandard =
      'This VM has been configured to produce stack traces that violate the Dart standard.';

  /// returns the [Backtrace] list from a stackTrace ([Chain])
  List<Backtrace>? getStackFrames(Chain? chain) {
    if (chain == null) {
      return null;
    }

    final List<Backtrace> frames = <Backtrace>[];
    bool symbolicated = true;

    for (int t = 0; t < chain.traces.length; t += 1) {
      final Trace trace = chain.traces[t];

      for (final Frame frame in trace.frames) {
        final String? member = frame.member;
        // ideally the language would offer us a native way of parsing it.
        if (member != null && member.contains(_stackTraceViolateDartStandard)) {
          symbolicated = false;
        }

        final Backtrace? stackTraceFrame = encodeStackTraceFrame(
          frame,
          symbolicated: symbolicated,
        );

        if (stackTraceFrame == null) {
          continue;
        }

        frames.add(stackTraceFrame);
      }
    }

    return frames.toList();
  }

  /// converts [Frame] to [Backtrace]
  @visibleForTesting
  Backtrace? encodeStackTraceFrame(
    Frame frame, {
    bool symbolicated = true,
  }) {
    Backtrace? backtrace;

    if (symbolicated) {
      final String file = frame.library;
      final String? function = frame.member;

      backtrace = Backtrace(
        file: file,
        function: function,
        arguments: 'test',
      );

      if (frame.line != null && frame.line! >= 0) {
        backtrace = backtrace.copyWith(line: frame.line);
      }

      if (frame.column != null && frame.column! >= 0) {
        backtrace = backtrace.copyWith(column: frame.column);
      }
    }

    return backtrace;
  }
}
