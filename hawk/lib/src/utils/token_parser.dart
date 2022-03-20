import 'dart:convert';

/// Interface for parsing encoded token and get integration id
abstract class ITokenParser {
  const ITokenParser();

  /// Key for getting integration id from token
  static const String integrationIdKey = 'integrationId';

  /// Default value for unknown token
  static const String unknownIntegrationId = 'unknown';

  /// Get encoded token and return integration id
  String parse(String encodedToken);
}

/// Implementation of [ITokenParser]
class TokenParser implements ITokenParser {
  const TokenParser();

  @override
  String parse(String encodedToken) {
    try {
      final Map<String, dynamic> data =
          jsonDecode(utf8.decode(base64Decode(encodedToken)))
              as Map<String, dynamic>;
      return data[ITokenParser.integrationIdKey]?.toString() ??
          ITokenParser.unknownIntegrationId;
    } on Object catch (_) {
      return ITokenParser.unknownIntegrationId;
    }
  }
}
