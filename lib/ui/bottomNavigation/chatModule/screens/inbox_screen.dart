import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';
import 'inbox_tabs_screen.dart';


class InboxScreen extends StatelessWidget {
  const InboxScreen({Key? key}) : super(key: key);

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
                    children: const [
                      Expanded(
                        child: Text(
                          "Inbox",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppColor.heading_text,
                            fontSize: 24,
                          ),
                        ),
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
