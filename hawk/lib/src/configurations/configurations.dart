import '../addons/addon.dart';
import '../addons/custom_addon.dart';

abstract class IHawkConfigurations {
  abstract final String integrationId;

  abstract final bool isCorrect;

  abstract final List<IAddon> addons;

  abstract final List<IAddon> customAddons;

  void addCustomAddon(ICustomAddon customAddon);
  void removeCustomAddon(ICustomAddon customAddon);
  void removeCustomAddonByName(String name);
}
