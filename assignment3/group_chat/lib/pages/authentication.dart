import 'package:flutter/material.dart';
import 'package:group_chat/forms/loginform.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Authentication"),
        ),
        body: const LoginForm());
  }
}
