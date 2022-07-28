import 'package:group_chat/models/conversation.dart';
import 'package:group_chat/pages/chat.dart';
import 'package:group_chat/pages/create_conversation.dart';
import 'package:group_chat/services/firestore_service.dart';
import 'package:flutter/material.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({Key? key}) : super(key: key);

  @override
  State<ConversationsPage> createState() => _ConversationsState();
}

class _ConversationsState extends State<ConversationsPage> {
  final FirestoreService _fs = FirestoreService();
  @override
  void initState() {
    super.initState();
    _fs.setUserConvoserations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversations"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateConversationsPage()));
              },
              icon: const Icon(Icons.add)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: StreamBuilder<List<Conversation>>(
          stream: _fs.userConvos,
          builder: (BuildContext context,
              AsyncSnapshot<List<Conversation>> snapshot) {
            if (snapshot.hasData) {
              List<Conversation> convos = snapshot.data!;
              return convos.isEmpty
                  ? Text(_fs.getUserId())
                  : ListView.builder(
                      itemCount: convos.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(conversationName(convos[index])),
                          onTap: () => goToConversation(convos[index]),
                        );
                      });
            } else {
              return const Center(child: Text("Are No Conversations"));
            }
          }),
    );
  }

  String conversationName(Conversation convo) {
    var convoname = "";

    for (var user in convo.users) {
      if (user != _fs.getUserId()) {
        if (convoname.isEmpty) {
          convoname = FirestoreService.userMap[user]!.username.toUpperCase();
        } else {
          convoname +=
              ", ${FirestoreService.userMap[user]!.username.toUpperCase()}";
        }
      }
    }
    return convoname;
  }

  void goToConversation(Conversation convo) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>
            ChatPage(conversation: convo, name: conversationName(convo))));
  }
}
