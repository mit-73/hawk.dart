/// Interface that can apply own information to event
abstract class IAddon {
  const IAddon();

  ///  Apply data to json event
  Map<String, dynamic> fillJsonObject(Map<String, dynamic> json);
}
