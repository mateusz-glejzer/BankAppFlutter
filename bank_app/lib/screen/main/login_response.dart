import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class LoginResponse {
  final String token;
  final LoginError? loginError;
  const LoginResponse(this.token, this.loginError);
  factory LoginResponse.fromJson(Map<dynamic, dynamic> json) => LoginResponse(
      json["token"], LoginError(json["loginError"]?["message"]));
}

@JsonSerializable()
class LoginError {
  final String? message;
  const LoginError(this.message);
}
