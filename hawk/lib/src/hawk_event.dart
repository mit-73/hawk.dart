class HawkEvent {
  const HawkEvent({
    required this.token,
    required this.catcherType,
    required this.payload,
  });

  factory HawkEvent.fromJson(Map<String, dynamic> json) {
    return HawkEvent(
      token: json['token'] as String,
      catcherType: json['catcherType'] as String,
      payload: Payload.fromJson(json['payload'] as Map<String, dynamic>),
    );
  }

  final String token;
  final String catcherType;
  final Payload payload;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'token': token,
        'catcherType': catcherType,
        'payload': payload.toJson(),
      };

  HawkEvent copyWith({
    String? token,
    String? catcherType,
    Payload? payload,
  }) {
    return HawkEvent(
      token: token ?? this.token,
      catcherType: catcherType ?? this.catcherType,
      payload: payload ?? this.payload,
    );
  }
}

class Payload {
  const Payload({
    required this.title,
    this.type,
    this.description,
    this.level,
    this.backtrace,
    this.addons = const <String, dynamic>{},
    this.release,
    this.user,
    this.context,
    this.catcherVersion,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? backtraceJson = json['backtrace'] as List<dynamic>?;
    final List<Backtrace> backtrace = backtraceJson
            ?.map((dynamic e) => Backtrace.fromJson(
                e is Map<String, dynamic> ? e : <String, dynamic>{}))
            .toList(growable: false) ??
        <Backtrace>[];

    final Map<String, dynamic>? addonsJson =
        json['addons'] as Map<String, dynamic>?;
    final Map<String, dynamic> addons = addonsJson ?? <String, dynamic>{};

    final Map<String, dynamic>? userJson =
        json['user'] as Map<String, dynamic>?;
    final HawkUser? user =
        userJson != null ? HawkUser.fromJson(userJson) : null;

    final Map<String, dynamic>? contextJson =
        json['context'] as Map<String, dynamic>?;
    final Map<String, dynamic> context = contextJson ?? <String, dynamic>{};

    return Payload(
      title: json['title'] as String,
      type: json['type'] as String?,
      description: json['description'] as String?,
      level: json['level'] as int?,
      backtrace: backtrace,
      addons: addons,
      release: json['release'] as String?,
      user: user,
      context: context,
      catcherVersion: json['catcherVersion'] as String?,
    );
  }

  final String title;
  final String? type;
  final String? description;
  final int? level;
  final List<Backtrace>? backtrace;
  final Map<String, dynamic> addons;
  final String? release;
  final HawkUser? user;
  final Map<String, dynamic>? context;
  final String? catcherVersion;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'title': title,
        'type': type,
        'description': description,
        'level': level,
        if (backtrace?.isNotEmpty == true)
          'backtrace': backtrace
              ?.map((Backtrace x) => x.toJson())
              .toList(growable: false),
        'addons': addons,
        'release': release,
        'user': user?.toJson(),
        'context': context,
        'catcherVersion': catcherVersion,
      };

  Payload copyWith({
    String? title,
    String? type,
    String? description,
    int? level,
    List<Backtrace>? backtrace,
    Map<String, dynamic>? addons,
    String? release,
    HawkUser? user,
    Map<String, dynamic>? context,
  }) {
    return Payload(
      title: title ?? this.title,
      type: type ?? this.type,
      description: description ?? this.description,
      level: level ?? this.level,
      backtrace: backtrace ?? this.backtrace,
      addons: addons ?? this.addons,
      release: release ?? this.release,
      user: user ?? this.user,
      context: context ?? this.context,
    );
  }
}

class Backtrace {
  const Backtrace({
    required this.file,
    this.line,
    this.column,
    this.function,
    this.arguments,
    this.sourceCode,
  });

  factory Backtrace.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? sourceCodeJson = json['sourceCode'] as List<dynamic>?;
    final List<SourceCode>? sourceCode = sourceCodeJson
        ?.map((dynamic e) => SourceCode.fromJson(
            e is Map<String, dynamic> ? e : <String, dynamic>{}))
        .toList(growable: false);

    return Backtrace(
      file: json['file'] as String,
      line: json['line'] as int?,
      column: json['column'] as int?,
      function: json['function'] as String?,
      arguments: json['arguments'],
      sourceCode: sourceCode,
    );
  }

  final String file;
  final int? line;
  final int? column;
  final String? function;
  final dynamic arguments;
  final List<SourceCode>? sourceCode;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'file': file,
        'line': line,
        'column': column,
        'function': function,
        'arguments': arguments,
        if (sourceCode?.isNotEmpty == true)
          'sourceCode': sourceCode
              ?.map((SourceCode x) => x.toJson())
              .toList(growable: false),
      };

  Backtrace copyWith({
    String? file,
    int? line,
    int? column,
    String? function,
    dynamic arguments,
    List<SourceCode>? sourceCode,
  }) {
    return Backtrace(
      file: file ?? this.file,
      line: line ?? this.line,
      column: column ?? this.column,
      function: function ?? this.function,
      arguments: arguments ?? this.arguments,
      sourceCode: sourceCode ?? this.sourceCode,
    );
  }
}

class SourceCode {
  const SourceCode({
    required this.line,
    required this.content,
  });

  factory SourceCode.fromJson(Map<String, dynamic> json) => SourceCode(
        line: json['line'] as int,
        content: json['content'] as String,
      );

  final int line;
  final String content;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'line': line,
        'content': content,
      };

  SourceCode copyWith({
    int? line,
    String? content,
  }) {
    return SourceCode(
      line: line ?? this.line,
      content: content ?? this.content,
    );
  }
}

class HawkUser {
  const HawkUser({
    required this.id,
    required this.name,
    this.url,
    this.photo,
  });

  factory HawkUser.fromJson(Map<String, dynamic> json) => HawkUser(
        id: json['id'] as String,
        name: json['name'] as String,
        url: json['url'] as String?,
        photo: json['photo'] as String?,
      );

  final String id;
  final String name;
  final String? url;
  final String? photo;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'url': url,
        'photo': photo,
      };

  HawkUser copyWith({
    String? id,
    String? name,
    String? url,
    String? photo,
  }) {
    return HawkUser(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      photo: photo ?? this.photo,
    );
  }
}
