import 'package:flutter/material.dart';
import 'package:create_social/models/user.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key, required this.observedUser}) : super(key: key);

  final User observedUser;

  @override
  State<Profile> createState() => _State();
}

class _State extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.observedUser.username)),
      body: Center(
        child: Text(widget.observedUser.bio),
      ),
    );
  }
}
