
import 'package:flutter/material.dart';

typedef NotificationViewCallback = void Function(bool status);
typedef OnTextInputChangeCallback = void Function(String val);
typedef CustomAlertCompleteActionCallback = void Function();
typedef CustomAlertActionCallback = void Function();
typedef DropdownValueSelectionCallback = void Function(String value);

typedef AlertWidgetButtonActionCallback = void Function(int index);
typedef CustomAlertWidgetButtonActionCallback = void Function(int index);
typedef AlertTextFieldWidgetButtonActionCallback = void Function(int index, TextEditingController controller);
