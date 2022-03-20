/// It is an information model of the user who has events
/// - [id] unique user ID
/// - [name] name of user, if present. By default, is empty string
class User {
  const User({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;
}

/// This is interface user to provide information of user. All caught events are added by user ID
abstract class IUserProvider {
  const IUserProvider();

  /// Default user provider
  const factory IUserProvider.byDefault() = _DefaultUserProvider;

  User? currentUser();
}

class _DefaultUserProvider implements IUserProvider {
  const _DefaultUserProvider();

  @override
  User? currentUser() => null;
}
