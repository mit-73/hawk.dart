import '../addons/addon.dart';
import '../addons/custom_addon.dart';
import '../addons/custom_addon_wrapper.dart';
import '../logger.dart';
import '../utils/token_parser.dart';
import 'configurations.dart';

/// Common configuration for stable work with default list of addons that should be used for sending additional information
class HawkConfigurations implements IHawkConfigurations {
  HawkConfigurations({
    required String token,
    required ITokenParser tokenParser,
    required ILogger logger,
    List<IAddon> defaultAddons = const <IAddon>[],
    List<ICustomAddon> customAddons = const <ICustomAddon>[],
  })  : _integrationId = tokenParser.parse(token),
        _defaultAddons = List<IAddon>.of(defaultAddons),
        _logger = logger,
        _customAddons = <String, IAddon>{
          for (ICustomAddon v in customAddons) v.name: CustomAddonWrapper(v)
        };

  final String _integrationId;

  final List<IAddon> _defaultAddons;
  final Map<String, IAddon> _customAddons;

  final ILogger _logger;

  @override
  String get integrationId => _integrationId;

  @override
  bool get isCorrect => _integrationId != ITokenParser.unknownIntegrationId;

  @override
  List<IAddon> get addons => _defaultAddons;

  @override
  List<IAddon> get customAddons => _customAddons.values.toList(growable: false);

  @override
  void addCustomAddon(ICustomAddon customAddon) {
    if (_customAddons.containsKey(customAddon.name)) {
      _logger.w('User addon with name (${customAddon.name}) already added!');
    }
    _customAddons[customAddon.name] = CustomAddonWrapper(customAddon);
  }

  @override
  void removeCustomAddon(ICustomAddon customAddon) {
    final IAddon? addon = _customAddons.remove(customAddon.name);
    if (addon == null) {
      _logger.w('User addon with name (${customAddon.name}) already removed!');
    }
  }

  @override
  void removeCustomAddonByName(String name) {
    final IAddon? addon = _customAddons.remove(name);
    if (addon == null) {
      _logger.w('User addon with name ($name) already removed!');
    }
  }
}
