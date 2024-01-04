class User {
  final int id;
  final String username;
  final List<String> roles;
  final String token;

  const User({
    required this.id,
    required this.username,
    required this.roles,
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      username: json['username'] as String,
      roles: List<String>.from(json['roles']),
      token: json['token'] as String,
    );
  }
}
