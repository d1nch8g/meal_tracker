class User {
  final String id;
  final String login;
  final String name;

  const User({
    required this.id,
    required this.login,
    required this.name,
  });

  User copyWith({
    String? id,
    String? login,
    String? name,
  }) {
    return User(
      id: id ?? this.id,
      login: login ?? this.login,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'login': login,
      'name': name,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      login: json['login'] ?? '',
      name: json['name'] ?? '',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id && other.login == login && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ login.hashCode ^ name.hashCode;
}
