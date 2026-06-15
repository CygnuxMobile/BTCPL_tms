import 'dart:convert';

LoginCredential loginCrediantialFromJson(String str) => LoginCredential.fromJson(json.decode(str));

String loginCrediantialToJson(LoginCredential data) => json.encode(data.toJson());

class LoginCredential {
  LoginCredential({
    required this.username,
    required this.password,
  });

  final String username;
  final String password;

  factory LoginCredential.fromJson(Map<String, dynamic> json) => LoginCredential(
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
  };
}
