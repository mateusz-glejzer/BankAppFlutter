import 'package:bank_app/screen/main/login_data.dart';
import 'package:bank_app/screen/main/login_response.dart';
import 'package:bank_app/screen/main/login_service.dart';
import 'package:flutter/cupertino.dart';

class Login extends StatefulWidget {
  final Function(String)? onLogged;
  const Login({super.key, this.onLogged});

  @override
  State<StatefulWidget> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late Function(String token) onLogged = (token) => widget.onLogged!(token);
  late TextEditingController _loginTextController;
  late TextEditingController _passwordTextController;

  @override
  void initState() {
    super.initState();
    _loginTextController = TextEditingController(text: 'Login');
    _passwordTextController = TextEditingController(text: 'Password');
  }

  @override
  Widget build(BuildContext context) {
    LoginResponse loginResponse;
    return Column(children: [
      CupertinoTextField(controller: _loginTextController),
      CupertinoTextField(controller: _passwordTextController),
      CupertinoButton(
          onPressed: () async => {
                loginResponse = await login(LoginData(
                    _loginTextController.text as String,
                    _passwordTextController.text as String)),
                if (loginResponse.token == null)
                  {}
                else
                  onLogged(loginResponse.token),
              },
          child: const Text("Login"))
    ]);
  }
}
