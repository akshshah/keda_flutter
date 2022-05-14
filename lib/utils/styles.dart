import 'package:flutter/material.dart';

import 'app_color.dart';

class Styles {

  static InputDecoration myInputDecoration(String text) {
    return InputDecoration(
      isDense: true,
      labelText: text,
      contentPadding: const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      labelStyle: const TextStyle(fontSize: 17, color: AppColor.heading_text_50),
      floatingLabelStyle: const TextStyle(fontSize: 16, color: AppColor.colorPrimary),
      alignLabelWithHint: true,
    );
  }

  static SizedBox myFullButton(String text, Function function){
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => function(),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 1.5, fontSize: 16),),
      ),
    );
  }
}