import 'package:flutter/material.dart';
import 'package:create_social/pages/authentication.dart';
import 'package:create_social/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Driver extends StatefulWidget {
  const Driver({Key? key}) : super(key: key);

  @override
  State<Driver> createState() => _State();
}

class _State extends State<Driver> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return _auth.currentUser == null ? const Auth() : const HomePage();
  }
}
