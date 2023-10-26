class LoginData
{
final String login;
final String password;
const LoginData(this.login, this.password);
Map<String, dynamic> toJson() {
    return {
      'Login': login,
      'Password': password,
    };
  }
}