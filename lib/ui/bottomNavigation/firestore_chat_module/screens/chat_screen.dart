import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/bottomNavigation/firestore_chat_module/screens/auth_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/firestore_chat_module/widgets/messages.dart';
import 'package:keda_flutter/ui/bottomNavigation/firestore_chat_module/widgets/new_message.dart';

import '../../../../utils/app_color.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  static const routeName = "/chat-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Screen"),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: Divider(
            height: 2,
            color: AppColor.dark_sky_blue,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: DropdownButton(
              underline: const SizedBox(),
              onChanged: (value) async {
                if (value == 'logout')  {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, AuthScreen.routeName);
                }
              },
              icon: const Icon(
                Icons.more_vert_rounded,
                color: AppColor.heading_text,
                size: 30,
              ),
              items: [
                DropdownMenuItem(
                  child: Row(
                    children: const [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Logout"),
                    ],
                  ),
                  value: 'logout',
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}

