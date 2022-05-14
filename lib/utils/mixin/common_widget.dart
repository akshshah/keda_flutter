import 'package:flutter/material.dart';
import '../../control/input/ai_text_form_field.dart';
import '../../control/input/text_field_helper.dart';
import '../app_color.dart';
import '../ui_text_style.dart';

class CommonWidget {

  static Widget createTextField(
      {TextFieldType textType = TextFieldType.none,
        Key? key,
        TextInputType? keyboardType,
        TextInputAction action = TextInputAction.next,
        VoidCallback? onEditComplete,
        ValueChanged<String>? onChanged,
        FocusNode? focusNode,
        TextEditingController? controller,
        Color? cursorColor,
        TextStyle? style,
        InputDecoration? decoration,
        String? hintText,
        String? labelText,
        Widget? prefixIcon,
        // EdgeInsets prefixPadding = const EdgeInsets.only(right: 10),
        Color prefixIconColor = const Color(0xFFD8D8D8),
        Widget? suffixIcon,
        EdgeInsetsGeometry? contentPadding,
        bool? enabled,
        GestureTapCallback? gestureTapCallback,
        TextCapitalization textCapitalization = TextCapitalization.none,
        bool obscureText = false,
        int? maxLength,
        int maxLines = 1,
        TextAlign align = TextAlign.left,
        TextStyle? hintTextStyle,
        TextStyle? labelTextStyle,
        TextStyle? floatingTextStyle}) {

    var textStyle = style;
    textStyle ??= UITextStyle.regularTextStyle(color: AppColor.heading_text, fontSize: 18);
    // hintTextStyle ??= UITextStyle.mediumTextStyle(color: AppColor.hintTextColor, fontSize: 13);
    labelTextStyle ??= UITextStyle.regularTextStyle(fontSize: 17, color: AppColor.heading_text_50);
    floatingTextStyle ??= UITextStyle.regularTextStyle(fontSize: 16, color: AppColor.colorPrimary);

    var inputDecoration = decoration;
    inputDecoration ??= InputDecoration(
        hintText: hintText,
        labelText: labelText,
        contentPadding: contentPadding ??  const EdgeInsets.symmetric(horizontal: 1, vertical: 5),
        //focusedBorder: InputBorder.none,
        //enabledBorder: InputBorder.none,
        hintStyle: hintTextStyle,
        labelStyle: labelTextStyle,
        floatingLabelStyle: floatingTextStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        isDense: true,
        alignLabelWithHint: true
      );


    return AITextFormField(
      key: key,
      maxLength: maxLength,
      textType: textType,
      keyboardType: keyboardType,
      autoFocus: false,
      action: action,
      onEditingComplete: onEditComplete,
      onChanged: onChanged,
      controller: controller,
      focusNode: focusNode,
      cursorColor: (cursorColor != null) ? cursorColor : AppColor.heading_text,
      style: textStyle,
      decoration: inputDecoration,
      enabled: enabled ?? true,
      gestureTapCallback: gestureTapCallback,
      textCapitalization: textCapitalization,
      obscureText: textType == TextFieldType.password ? true : obscureText,
      maxLines: maxLines,
      textAlign: align,
    );
  }


  static SizedBox myFullButton(String text, Function function){
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => function(),
        child: Text(text, style: UITextStyle.boldTextStyle(letterSpacing: 1.5, fontSize: 16, color: AppColor.whiteColor),),
      ),
    );
  }
}
