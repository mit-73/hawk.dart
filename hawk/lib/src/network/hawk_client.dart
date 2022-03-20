import 'dart:async';

import 'package:http/http.dart';

import '../logger.dart';

class HawkClient {
  HawkClient({
    required String integrationId,
    required ILogger logger,
  })  : _url = Uri.https('$integrationId.k1.hawk.so', '/'),
        _logger = logger;

  static const Duration defaultTimeout = Duration(milliseconds: 10000);
  static const String propertyContentTypeKey = 'Content-Type';
  static const String propertyContentTypeValue =
      'application/json;charset=UTF-8';

  final Uri _url;
  final ILogger _logger;

  ///Send Event by URL. [eventJson] contains all information about Event
  void sendEvent(String eventJson) {
    post(
      _url,
      headers: <String, String>{
        propertyContentTypeKey: propertyContentTypeValue,
      },
      body: eventJson,
    ).timeout(
      defaultTimeout,
      onTimeout: () {
        _logger.w('connection timeout');
        return Future<Response>.error(
            TimeoutException('connection timeout', defaultTimeout));
      },
    ).catchError((Object e, StackTrace? st) {
      _logger.e('connection error', e, st);
    }).then((Response response) {
      _logger.i('connection response status ${response.statusCode}');
      _logger.i('connection response message ${response.body}');
    }).whenComplete(() {
      _logger.i('connection complete');
    });
  }
}
