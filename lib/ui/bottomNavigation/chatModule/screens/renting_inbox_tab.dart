import 'package:flutter/material.dart';

import '../models/RecentChat.dart';
import '../widget/recent_chat_widget.dart';

class RentingInboxTab extends StatelessWidget {
  const RentingInboxTab({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async{
    try {
    } catch (e) {

    }
  }

  final List<RecentChat> _myList = const [
    RecentChat(id: "1", productName: "New Product", category: "Clothes",
        username: "Aksh Shah", type: 1, lastMessage: "Good Morning", time: "May 02, 10:51 AM"),
    RecentChat(id: "3", productName: "Shampoo", category: "General",
        username: "Rahul Patel", type: 2, lastMessage: "Can we talk now?", time: "Apr 25, 5:05 PM"),
    RecentChat(id: "2", productName: "Bottle", category: "Furniture",
        username: "Rohan Gupta", type: 3, lastMessage: "Where are you?", time: "Apr 15, 12:51 PM"),


  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: RefreshIndicator(
          onRefresh: () => _refreshProducts(context),
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return RecentChatWidget(recentChat: _myList[index]);
            },
            itemCount: _myList.length,
          )
      ),
    );
  }
}
