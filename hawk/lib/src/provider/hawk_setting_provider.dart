import 'version_provider.dart';

/// This is interface used to implement hawk setting
abstract class IHawkSettingProvider {
  const IHawkSettingProvider();

  /// Get version name of application
  abstract final String versionName;

  /// Get application version code
  abstract final int appVersion;

  /// Get Hawk token
  abstract final String token;
}

/// Work with version provider
/// - [token] Hawk token
/// - [versionProvider] Contains version information of application
class DefaultSettingProvider implements IHawkSettingProvider {
  DefaultSettingProvider({
    required this.token,
    required IVersionProvider versionProvider,
  })  : appVersion = versionProvider.getAppVersion,
        versionName = versionProvider.getVersionName;

  @override
  final int appVersion;

  @override
  final String versionName;

  @override
  final String token;
}
