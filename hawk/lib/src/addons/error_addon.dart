import 'addon.dart';

class ErrorAddon implements IAddon {
  const ErrorAddon(this.error);

  final Object error;

  @override
  Map<String, dynamic> fillJsonObject(Map<String, dynamic> json) {
    return json
      ..addAll(
        <String, dynamic>{
          'Error': error.toString(),
        },
      );
  }
}
