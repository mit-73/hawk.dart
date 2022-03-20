import '../platform/platform_checker.dart';
import 'addon.dart';

class PlatformAddon implements IAddon {
  const PlatformAddon();

  @override
  Map<String, dynamic> fillJsonObject(Map<String, dynamic> json) {
    return json
      ..addAll(
        <String, dynamic>{
          'OS': platformChecker.platform.operatingSystem,
          'OS Version': platformChecker.platform.operatingSystemVersion,
          'Hostname': platformChecker.platform.localHostname,
          'Compile mode': platformChecker.compileMode,
          'Has native integration': platformChecker.hasNativeIntegration,
          'Is web': platformChecker.isWeb,
        },
      );
  }
}
