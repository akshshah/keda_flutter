import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:keda_flutter/providers/chat_screen_provider.dart';
import 'package:keda_flutter/ui/bottomNavigation/firestore_chat_module/screens/auth_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/firestore_chat_module/screens/chat_screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/ui_text_style.dart';
import '../../../../utils/utils.dart';
import 'inbox_tabs_screen.dart';


class InboxScreen extends StatelessWidget {
  const InboxScreen({Key? key}) : super(key: key);

  sendChatMessage(BuildContext context) async {
    final response = await Provider.of<ChatProvider>(context, listen: false).sendChatMessageAPI();
    Logger().e("Response Code : === ${response.status} " );
    if (response.status == 200) {

    }
    else {
      Utils.showSnackBarWithContext(context, response.message?? "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Inbox",
                          style: UITextStyle.semiBoldTextStyle(fontSize: 24),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // StreamBuilder(
                          //   stream: FirebaseAuth.instance.authStateChanges(),
                          //   builder: (ctx, snapshot){
                          //     if(snapshot.hasData){
                          //       Navigator.of(context).pushNamed(ChatScreen.routeName);
                          //     }
                          //     else{
                          //       Navigator.of(context).pushNamed(AuthScreen.routeName);
                          //     }
                          //     return Card();
                          //   },
                          // );

                          User? user = FirebaseAuth.instance.currentUser;
                          if(user == null){
                            Navigator.of(context).pushNamed(AuthScreen.routeName);
                          }
                          else{
                            Navigator.of(context).pushNamed(ChatScreen.routeName);
                          }

                        },
                        icon: const Icon(IcoFontIcons.uiChat),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                  const Divider(thickness: 1, color: AppColor.light_sky_blue,),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColor.light_sky_blue,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search, color: AppColor.heading_text,),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: "Search your inbox",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  const Divider(thickness: 1, color: AppColor.light_sky_blue,),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const InboxTabsScreen(),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
