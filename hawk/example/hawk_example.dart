// ignore_for_file: avoid_print

import 'package:hawk/hawk.dart';

const String token =
    'eyJpbnRlZ3JhdGlvbklkIjoiNGIyNDcwNzMtODI3My00N2YyLTgxMDEtZjhiODg5ZDFjNTUwIiwic2VjcmV0IjoiN2Y1NjdhN2UtZDc5Mi00NDUxLWIzYzQtNDk5ZDU2YmM3ZDhmIn0=';

void main() => Hawk.init(
      test,
      HawkOptions.base(token: token, isDebug: true),
    );

void test() {
  final int i = 1 ~/ 0;
  print(i);
}
