/// Interface that can apply own information to event
abstract class IAddon {
  const IAddon();

  ///  Apply data to json event
  void fillJsonObject(Map<String, dynamic> json);
}
