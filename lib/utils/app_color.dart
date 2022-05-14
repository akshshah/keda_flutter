import 'package:flutter/material.dart';

class AppColor{

  static const MaterialColor primarySwatch = MaterialColor(
    0xff036ED9, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0x1a036ed9),//10%
      100: Color(0x33036ed9),//20%
      200: Color(0x4d036ed9),//30%
      300: Color(0x66036ed9),//40%
      400: Color(0x80036ed9),//50%
      500: Color(0x99036ed9),//60%
      600: Color(0xb3036ed9),//70%
      700: Color(0xcc036ed9),//80%
      800: Color(0xe6036ed9),//90%
      900: Color(0xff036ED9),//100%
    },
  );



  static const Color colorPrimary = Color(0xff036ED9);
  static const Color whiteColor = Color(0xffffffff);
  static const Color colorPrimaryDark = Color(0xff0261BF);
  static const Color colorAccent = Color(0xffD81B60);
  static const Color disableDate = Color(0x70D81B60);
  static Color transparentColor = Colors.transparent;
  static Color dividerColor = const Color(0xFF858788);
  static Color hintTextColor = const Color(0xFF858788);

  static const Color gray = Color(0xffaaaaaa);
  static const Color heading_text = Color(0xff0B486B);
  static const Color heading_text_50 = Color(0x800B486B);
  static const Color heading_text_08 = Color(0x140B486B);
  static const Color heading_text_10 = Color(0x1A0B486B);
  static const Color heading_text_14 = Color(0x240B486B);
  static const Color heading_text_68 = Color(0xAD0B486B);
  static const Color heading_text_78 = Color(0xC70B486B);

  static const Color underline_color = Color(0xff707070);
  static const Color light_sky_blue = Color(0xffE5F5F7);
  static const Color dark_sky_blue = Color(0xff00A0B0);
  static const Color chat_send_bg = Color(0xffDEF0F2);
  static const Color light_sky_blue_edit_text = Color(0xffF3F8FE);

  static const Color tab_unselected = Color(0xffACBAC3);
  static const Color windowBackground = Color(0xff1C1C1C);
  static const Color colorButtonNormal = Color(0xffFFFFFB);
  static const Color textColorPrimary = Color(0xffFFFFFB);
  static const Color textColorPrimaryInverse = Color(0xff1C1C1C);
  static const Color divider = Color(0xff333333);
  static const Color price_color = Color(0xff3B8686);


  static const Color star_filled = Color(0xcb0b6c6c);
  static const Color star_empty = Color(0x633b8686);

  static const Color status_active = Color(0xff139B62);
  static const Color status_deactive = Color(0xffD8A742);
  static const Color switch_track_color = Color(0x14000000);


  static const Color status_on_hold = Color(0xff5895D3);
  static const Color status_credited = Color(0xff3B864F);
  static const Color status_debited = Color(0xffDD7D6C);
  static const Color pending_request = Color(0xFF61A2C3);


}