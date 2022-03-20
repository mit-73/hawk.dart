import 'addons/addon.dart';
import 'addons/custom_addon.dart';
import 'addons/custom_addon_wrapper.dart';
import 'addons/error_addon.dart';
import 'configurations/configurations.dart';
import 'hawk_event.dart';
import 'logger.dart';
import 'platform/platform_checker.dart';
import 'provider/hawk_setting_provider.dart';
import 'provider/user_provider.dart';
import 'stack_trace_factory.dart';
import 'throwable.dart';
import 'version.dart';

class EventHandler {
  const EventHandler({
    required IHawkConfigurations configurations,
    required IHawkSettingProvider settingProvider,
    required IUserProvider userProvider,
    required ILogger logger,
  })  : _configurations = configurations,
        _settingProvider = settingProvider,
        _userProvider = userProvider,
        _logger = logger;

  final IHawkConfigurations _configurations;
  final IHawkSettingProvider _settingProvider;
  final IUserProvider _userProvider;
  final ILogger _logger;

  Map<String, dynamic> formingJsonExceptionInfo({
    required Throwable throwable,
    bool isFatal = true,
    ICustomAddon? externalCustomAddon,
  }) {
    final List<IAddon> customAddons = <IAddon>[
      ..._configurations.customAddons,
      if (externalCustomAddon != null) CustomAddonWrapper(externalCustomAddon)
    ];

    final Payload _payload = payload(
      throwable: throwable,
      defaultAddons: _configurations.addons,
      isFatal: isFatal,
      customAddons: customAddons,
    );

    final Map<String, dynamic> reportJson = HawkEvent(
      token: _settingProvider.token,
      catcherType: 'errors/${platformChecker.platform.operatingSystem}',
      payload: _payload,
    ).toJson();

    _logger.i('Post json: $reportJson');

    return reportJson;
  }

  Payload payload({
    required Throwable throwable,
    required List<IAddon> defaultAddons,
    bool isFatal = true,
    List<IAddon> customAddons = const <IAddon>[],
  }) {
    final StackTraceFactory stackTraceFactory = StackTraceFactory();

    final String title = throwable.message;
    final String type = throwable.type;
    final List<Backtrace>? backtrace =
        stackTraceFactory.getStackFrames(throwable.chain);
    final String versionName = _settingProvider.versionName;
    final int appVersion = _settingProvider.appVersion;
    final String release = '$versionName($appVersion)';
    final User? _user = _userProvider.currentUser();
    final HawkUser? user = _user != null
        ? HawkUser(
            id: _user.id,
            name: _user.name,
          )
        : null;

    final Map<String, dynamic> addons = <String, dynamic>{
      ...ErrorAddon(throwable.error).fillJsonObject(<String, dynamic>{}),
    };
    for (final IAddon v in defaultAddons) {
      addons.addAll(v.fillJsonObject(addons));
    }

    final Map<String, dynamic> context = <String, dynamic>{};
    for (final IAddon v in customAddons) {
      context.addAll(v.fillJsonObject(context));
    }

    return Payload(
      title: title,
      type: type,
      backtrace: backtrace,
      release: release,
      user: user,
      addons: addons,
      context: context,
      catcherVersion: sdkVersion,
    );
  }
}
