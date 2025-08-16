class Auth {
  Auth({
    required this.token,
    required this.role,
  });

  final String token;
  final String role;

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      token: json['access_token'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': token,
      'role': role,
    };
  }
}
