import 'dart:convert';

import 'addons/custom_addon.dart';
import 'base_logger.dart';
import 'configurations/configurations.dart';
import 'configurations/hawk_configurations.dart';
import 'event_handler.dart';
import 'logger.dart';
import 'network/hawk_client.dart';
import 'provider/hawk_setting_provider.dart';
import 'provider/user_provider.dart';
import 'provider/version_provider.dart';
import 'throwable.dart';
import 'utils/token_parser.dart';

class HawkOptions {
  const HawkOptions({
    required this.logger,
    required this.hawkSettingProvider,
    required this.hawkConfigurations,
    required this.userProvider,
  });

  factory HawkOptions.base({
    required String token,
    IVersionProvider versionProvider = const IVersionProvider.byDefault(),
    IUserProvider userProvider = const IUserProvider.byDefault(),
    bool isDebug = false,
  }) {
    const ITokenParser tokenParser = TokenParser();
    final ILogger logger = BaseLogger(isDebug: isDebug);

    return HawkOptions(
      logger: logger,
      hawkSettingProvider: DefaultSettingProvider(
        token: token,
        versionProvider: versionProvider,
      ),
      hawkConfigurations: HawkConfigurations(
        token: token,
        tokenParser: tokenParser,
        logger: logger,
      ),
      userProvider: userProvider,
    );
  }

  final ILogger logger;
  final IHawkSettingProvider hawkSettingProvider;
  final IHawkConfigurations hawkConfigurations;
  final IUserProvider userProvider;
}

class HawkCatcher {
  HawkCatcher({
    required this.hawkOptions,
  });

  late final EventHandler _eventHandler = EventHandler(
    configurations: hawkOptions.hawkConfigurations,
    settingProvider: hawkOptions.hawkSettingProvider,
    userProvider: hawkOptions.userProvider,
    logger: hawkOptions.logger,
  );

  late final HawkClient _client = HawkClient(
    integrationId: hawkOptions.hawkConfigurations.integrationId,
    logger: hawkOptions.logger,
  );

  final HawkOptions hawkOptions;

  /// Add user addon
  void addCustomAddon(ICustomAddon customAddon) =>
      hawkOptions.hawkConfigurations.addCustomAddon(customAddon);

  /// Remove user addon
  void removeCustomAddon(ICustomAddon customAddon) =>
      hawkOptions.hawkConfigurations.removeCustomAddon(customAddon);

  /// Remove user addon by [name]
  void removeCustomAddonByName(String name) =>
      hawkOptions.hawkConfigurations.removeCustomAddonByName(name);

  void caught(
    Throwable throwable, [
    ICustomAddon? customAddon,
  ]) {
    _startExceptionPostService(
      exceptionInfo: _eventHandler.formingJsonExceptionInfo(
        throwable: throwable,
        isFatal: false,
        externalCustomAddon: customAddon,
      ),
    );
  }

  void _startExceptionPostService({
    required Map<String, dynamic> exceptionInfo,
  }) {
    final String json = jsonEncode(exceptionInfo);

    _client.sendEvent(json);
  }
}
