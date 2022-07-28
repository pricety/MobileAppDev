import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:group_chat/main.dart';
import 'package:group_chat/pages/authentication2.dart';

import 'package:group_chat/style/style.dart';

import '../pages/home.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _email,
                  decoration: inputStyling("Enter Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email cannot be empty.";
                    } else if (!value.contains('@')) {
                      return "Email must be in the correct format.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _password,
                  decoration: inputStyling("Enter Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty";
                    } else if (value.length < 8) {
                      return "Password must be 8 or more characters long.";
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                OutlinedButton(
                    onPressed: () {
                      login(context);
                    },
                    child: const Text("LOGIN")),
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        moveToRegister();
                      });
                    },
                    child: const Text("SIGN UP")),
                OutlinedButton(
                    onPressed: () {
                      setState(() {
                        forgot();
                      });
                    },
                    child: const Text("FORGOT PASSWORD")),
              ],
            ),
          );
  }

  Future<void> login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential responseL = await _auth.signInWithEmailAndPassword(
            email: _email.text, password: _password.text);

        setState(() {
          if (responseL.user!.emailVerified) {
            snackBar(context, "Welcome back!");
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const HomePage()));
          } else {
            snackBar(
                context, "User logged in, but email has not been verified.");
            responseL.user!.sendEmailVerification();
          }
          loading = false;
        });
      } catch (e) {
        setState(() {
          snackBar(context, e.toString());
          loading = false;
        });
      }
    }
  }

  Future<void> forgot() async {
    if (_email.text.isNotEmpty) {
      _auth.sendPasswordResetEmail(email: _email.text);
      snackBar(context, "Reset Password has been sent to your email.");
    }
  }

  Future<void> moveToRegister() async {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => const Auth_2()));
  }
}
