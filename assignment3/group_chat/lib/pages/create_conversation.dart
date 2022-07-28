import 'package:group_chat/models/user.dart';
import 'package:group_chat/services/firestore_service.dart';
import 'package:group_chat/style/style.dart';
import 'package:flutter/material.dart';

class CreateConversationsPage extends StatefulWidget {
  const CreateConversationsPage({Key? key}) : super(key: key);

  @override
  State<CreateConversationsPage> createState() => _CreateState();
}

class _CreateState extends State<CreateConversationsPage> {
  final FirestoreService _fs = FirestoreService();
  List<User> userList = FirestoreService.userMap.values.toList();
  List<User> filter = [];
  List<String> recipients = [];
  String search = "";
  @override
  void initState() {
    super.initState();
    userList.remove(FirestoreService.userMap[_fs.getUserId()]);
    userList.sort(((a, b) =>
        a.username.toLowerCase().compareTo(b.username.toLowerCase())));
    filter = userList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Create Conversation",
            style: TextStyle(
                fontWeight: FontWeight.w700, fontStyle: FontStyle.italic),
          ),
          actions: recipients.isEmpty
              ? []
              : [
                  IconButton(
                      onPressed: createConvo, icon: const Icon(Icons.check))
                ],
        ),
        body: Column(children: [
          TextField(onChanged: (value) {
            List<User> temp = [];
            for (var user in userList) {
              if (user.username.contains(value)) {
                temp.add(user);
              }
            }
            setState(() {
              filter = temp;
            });
          }),
          SizedBox(
            height: 30,
            width: screenWidth(context),
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recipients.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Text(
                        FirestoreService.userMap[recipients[index]]!.username),
                  );
                }),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: filter.length,
                  itemBuilder: (BuildContext context, int index) {
                    var added = recipients.contains(filter[index].id);
                    return ListTile(
                      title: Text(filter[index].username),
                      trailing: added
                          ? const Icon(
                              Icons.verified,
                              color: Colors.green,
                            )
                          : null,
                      onTap: () {
                        setState(() {
                          if (added) {
                            recipients.remove(filter[index].id);
                          } else {
                            recipients.add(filter[index].id);
                          }
                        });
                      },
                    );
                  })),
        ]));
  }

  void createConvo() async {
    FirestoreService fs = FirestoreService();
    fs.addConversation(recipients);
  }
}
