/// Interface for additional information
abstract class ICustomAddon {
  const ICustomAddon();

  abstract final String name;

  Map<String, dynamic> provideData();
}
