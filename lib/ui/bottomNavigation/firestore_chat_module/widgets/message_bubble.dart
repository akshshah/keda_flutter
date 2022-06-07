import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keda_flutter/utils/app_color.dart';
import 'package:keda_flutter/utils/ui_text_style.dart';

import '../../../../utils/app_image.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({Key? key, required this.username, required this.message, required this.userImage, required this.isCurrentUser}) : super(key: key);

  final String message;
  final bool isCurrentUser;
  final String username;
  final String userImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Row(
          mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isCurrentUser ? AppColor.colorPrimary : AppColor.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(15),
                  topRight: const Radius.circular(15),
                  bottomLeft: isCurrentUser ? const Radius.circular(15) : Radius.zero,
                  bottomRight: !isCurrentUser ? const Radius.circular(15) : Radius.zero,
                ),
                border: Border.all(
                  color: AppColor.colorPrimary,
                  width: 2,
                ),
              ),
              constraints: BoxConstraints(maxWidth: 0.35.sh),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
              child: Column(
                crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  if (!isCurrentUser)
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        username,
                        style: UITextStyle.semiBoldTextStyle(
                          fontSize: 15,
                          color: isCurrentUser
                              ? AppColor.whiteColor
                              : AppColor.heading_text,
                        ),
                      ),
                    ),
                  if (!isCurrentUser)
                    const SizedBox(
                      height: 5,
                    ),
                  Text(
                    message,
                    textAlign: TextAlign.start,
                    style: UITextStyle.regularTextStyle(
                        color: isCurrentUser
                            ? AppColor.whiteColor
                            : AppColor.colorPrimary),
                  ),
                ],
              ),
            ),
          ],
        ),
        if(!isCurrentUser)
          Positioned(
            left: 5,
            top: -5,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2,
                  color: AppColor.colorPrimary,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: AppColor.gray,
                    offset: Offset(
                      3.0,
                      3.0,
                    ),
                    blurRadius: 5.0,
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage(AppImage.personImage),
                  fadeInDuration: const Duration(milliseconds: 100),
                  image: NetworkImage(userImage),
                  imageErrorBuilder: (ctx, error, stacktrace ) {
                    return Image.asset(AppImage.personImage, height: 40, width: 40, fit: BoxFit.cover,);
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}
