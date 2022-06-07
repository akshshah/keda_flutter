import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/bottomNavigation/firestore_chat_module/widgets/message_bubble.dart';


class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt', descending: true).snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = snapshot.data?.docs;
        // Logger().v("Messages len ${chatDocs?.length}");
        User? user = FirebaseAuth.instance.currentUser;
        return ListView.builder(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (ctx, index) => MessageBubble(
              key: ValueKey(chatDocs![index].id),
              username: chatDocs[index]['username'],
              message: chatDocs[index]['text'],
              userImage: chatDocs[index]['userImage'],
              isCurrentUser: chatDocs[index]['userId'] == user?.uid),
          itemCount: chatDocs?.length,
        );
      },
    );
  }
}
