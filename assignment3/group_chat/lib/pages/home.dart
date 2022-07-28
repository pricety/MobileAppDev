import 'package:group_chat/forms/postform.dart';
import 'package:group_chat/models/post.dart';
import 'package:group_chat/pages/conversations.dart';
import 'package:group_chat/services/firestore_service.dart';
import 'package:group_chat/widgets/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  final FirestoreService _fs = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Social Stream"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ConversationsPage()));
                },
                icon: const Icon(Icons.message)),
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: const Icon(Icons.logout_outlined))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showPostFeild,
          child: const Icon(Icons.post_add),
        ),
        body: StreamBuilder<List<Post>>(
          stream: _fs.posts,
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshots) {
            if (snapshots.hasError) {
              return Center(child: Text(snapshots.error.toString()));
            } else if (snapshots.hasData) {
              var posts = snapshots.data!;
              var filterpost = [];
              for (var element in posts) {
                if (element.creator == "SomeId") {
                  filterpost.add(element);
                }
              }

              return posts.isEmpty
                  ? const Center(child: Text("No Posts"))
                  : ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (BuildContext context, int index) =>
                          ListTile(
                              title: GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => Profile(
                                    //             observedUser: FirestoreService
                                    //                     .userMap[
                                    //                 posts[index].creator]!)));
                                  },
                                  child: Text(FirestoreService
                                      .userMap[posts[index].creator]!
                                      .username)),
                              subtitle: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(posts[index].content),
                                    const SizedBox(height: 10),
                                    Text(posts[index]
                                        .createdAt
                                        .toDate()
                                        .toString())
                                  ])));
            }
            return const Loading();
          },
        ));
  }

  //Displays a ModalPopUp that shows a text field and submit button for Post

  void _showPostFeild() {
    showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          return const PostForm();
        });
  }
}
