import 'addon.dart';
import 'custom_addon.dart';

/// Wrapper for converting from [ICustomAddon] to [IAddon]
class CustomAddonWrapper implements IAddon {
  const CustomAddonWrapper(
    this.customAddon,
  );

  final ICustomAddon customAddon;

  @override
  Map<String, dynamic> fillJsonObject(Map<String, dynamic> json) {
    return json..[customAddon.name] = customAddon.provideData();
  }
}
