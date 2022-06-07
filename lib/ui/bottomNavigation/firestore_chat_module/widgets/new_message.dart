import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:keda_flutter/utils/app_color.dart';


class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final TextEditingController _textController = TextEditingController();
  var _enteredMessage = "";
  final ScrollController _scrollController = ScrollController();

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    User? user = FirebaseAuth.instance.currentUser;
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user?.uid).get();
    await FirebaseFirestore.instance.collection("chat").add({
      "text" : _textController.text,
      "createdAt" : Timestamp.now(),
      "userId": user?.uid,
      "username": userDoc['username'],
      "userImage": userDoc['imageUrl'],
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.gray,
            offset: Offset(
              5.0,
              5.0,
            ),
            // blurStyle: BlurStyle.outer,
            blurRadius: 10.0,
            spreadRadius: 2.0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Scrollbar(
              thickness: 5,
              controller: _scrollController,
              child: TextField(
                decoration: const InputDecoration(
                  hintText: "Send a message...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15)
                ),
                controller: _textController,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value){
                  setState((){
                    _enteredMessage = value;
                  });
                },
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                minLines: 1,
                scrollController: _scrollController,
              ),
            ),
          ),
          const SizedBox(width: 10,),
          IconButton(
            onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
            icon: const Icon(
              Icons.send_rounded,
              color: AppColor.colorPrimary,
              size: 35,
            ),
            padding: const EdgeInsets.only(bottom: 10, right: 5),
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
}
