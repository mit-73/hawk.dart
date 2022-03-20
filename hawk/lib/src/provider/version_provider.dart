/// This is interface used to implement your own name and app version value.
abstract class IVersionProvider {
  const IVersionProvider();

  /// Default version provider
  /// - Default value of name is "v1"
  /// - Default value of app version is 1
  const factory IVersionProvider.byDefault() = _DefaultVersionProvider;

  /// Get version name of application
  abstract final String getVersionName;

  /// Get application version code
  abstract final int getAppVersion;
}

class _DefaultVersionProvider implements IVersionProvider {
  const _DefaultVersionProvider();

  @override
  int get getAppVersion => 1;

  @override
  String get getVersionName => 'v$getAppVersion';
}
