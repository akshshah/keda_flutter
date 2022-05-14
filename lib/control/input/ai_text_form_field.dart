import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'text_field_helper.dart';

class AITextFormField extends FormField<String> {

  final TextFieldType textType;
  final double? height;
  final TextInputAction action;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;
  final int? minLength;
  final int? maxLength;
  final int? maxLengthWithIndicator;
  final bool? autoFocus;
  final bool autoCorrect;
  final bool obscureText;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextCapitalization textCapitalization;
  final int maxLines;
  final Color? cursorColor;
  final bool enabled;
  final GestureTapCallback? gestureTapCallback;
  final bool? enableSuggestions;
  final ValueChanged<String>? onSubmitted;

  AITextFormField({
    Key? key,
    this.textType = TextFieldType.none,
    this.height ,
    this.action = TextInputAction.next,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.onEditingComplete,
    this.onChanged,
    this.decoration,
    this.minLength = 0,
    this.maxLength,
    this.maxLengthWithIndicator,
    this.autoFocus = false,
    this.autoCorrect = false,
    this.obscureText = false,
    this.style,
    this.textAlign = TextAlign.start,
    this.textCapitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.cursorColor,
    this.enabled=true,
    this.gestureTapCallback,
    this.onSubmitted,
    this.enableSuggestions = false

  }) : super(
      key: key,
      builder: (FormFieldState<String> field) => Container());

  @override
  _AITextFormFieldState createState() => _AITextFormFieldState();
}

class _AITextFormFieldState extends FormFieldState<String> {

  @override
  AITextFormField get widget => super.widget as AITextFormField;
  int? max, min;

  @override
  void initState() {
    super.initState();
    max = (widget.maxLength != null) ? widget.maxLength : getMaxLength(widget.textType);
    min = (widget.minLength != null) ? widget.minLength : getMinLength(widget.textType);

  }

  @override
  Widget build(BuildContext context) {

    List<TextInputFormatter> arrInputFormatter = getListOfFormatter(widget.textType, max);


    return SizedBox(
      // height: widget.height ?? 31.h,
      child: TextField(
        onTap: widget.gestureTapCallback,
        enabled: widget.enabled,
        keyboardType: widget.keyboardType ?? getKeyBoardType(widget.textType),
        textInputAction: widget.action,
        controller: widget.controller,
        focusNode: widget.focusNode,
        onEditingComplete: widget.onEditingComplete,
        onChanged: widget.onChanged,
        decoration: widget.decoration,
        autofocus: widget.autoFocus ?? false,
        autocorrect: widget.autoCorrect,
        enableSuggestions: widget.enableSuggestions ?? false,
        textCapitalization: widget.textCapitalization,
        obscureText: (widget.textType == TextFieldType.password) ? true : widget.obscureText,
        style: widget.style,
        textAlign: widget.textAlign,
        inputFormatters: arrInputFormatter,
        maxLines: widget.maxLines,
        maxLength: widget.maxLengthWithIndicator,
        cursorColor: widget.cursorColor,
      ),
    );
  }
}
