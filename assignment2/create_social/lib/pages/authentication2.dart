import 'package:flutter/material.dart';
import 'package:create_social/forms/registerform.dart';

class Auth_2 extends StatelessWidget {
  const Auth_2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Authentication"),
        ),
        body: const RegisterForm());
  }
}
