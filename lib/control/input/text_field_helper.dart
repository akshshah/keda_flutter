import 'dart:math';

import 'package:flutter/services.dart';
enum TextFieldType{
  email,
  password,
  passwordVisible,
  nameInputMultiLanguage,
  numericOnly,
  phoneNumber,
  charactersWithNumbers,
  charactersNumbersWithSpace,
  charactersWithSpecialCharacter,
  charactersSpecialCharacterWithSpace,
  none,
  nameWithSpace,
  cardExpiry,
  card,
  price,

}

class CharacterSetType {
  static const String emailRegex = "([a-zA-Z0-9_.’'@\-]+)*";    //r"([a-zA-Z0-9_.’'@\-]+)*";
  static const String passwordRegex = "[a-z0-9A-Z!@#\$%^&*(){}_+*/~`.?<>\-]*";   //r"^[a-z0-9A-Z!@#\$%^&*(){}_+*/~`.?<>\-]*";
  static const String nameWithSpaceRegex = "[a-zA-Z]+([a-zA-Z’' ]+)*";    //"^[a-zA-Z]+([a-zA-Z’' ]+)*";
  static const String numberOnlyRegex = '[0-9]*';     //r'^[0-9]*';
  static const String charactersWithNumbersRegex = '[a-z0-9A-Z]+([a-z0-9A-Z]+)*';       //r'^[a-z0-9A-Z]+([a-z0-9A-Z]+)*';
  static const String charactersNumbersWithSpaceRegex = '[a-z0-9A-Z]+([a-z0-9A-Z ]+)*';       //r'^[a-z0-9A-Z]+([a-z0-9A-Z ]+)*';
  static const String charactersWithSpecialCharacterRegex =  '([A-Za-z0-9!@#%^&_*+/~`.?<>(){}]+)*';       //r'^([A-Za-z0-9!@#%^&_*+/~`.?<>(){}]+)*';
  static const String charactersSpecialCharacterWithSpaceRegex = "([A-Za-z0-9,.’':!@#%^&_*+/~`?<>(){} \-]+)*";        //r"^([A-Za-z0-9.’'!@#%^&_*+/~`?<>(){} \-]+)*";
  static const String cardExpiryRegex = r'^[0-9/]*';
  static const String numericWithSpaceRegex = "[0-9 ]*";
}


List<TextInputFormatter> getListOfFormatter(TextFieldType type, int? maxLength) {

  List<TextInputFormatter> arrInputFormatter = [];

  if (type == TextFieldType.email) {
    arrInputFormatter.add(LengthLimitingTextInputFormatter(maxLength));
    arrInputFormatter.add(FilteringTextInputFormatter.allow(RegExp(CharacterSetType.emailRegex)));
  }
  else if ((type == TextFieldType.password) || (type == TextFieldType.passwordVisible)) {
    arrInputFormatter.add(LengthLimitingTextInputFormatter(maxLength));
    arrInputFormatter.add(FilteringTextInputFormatter.allow(RegExp(CharacterSetType.passwordRegex)));
  }
  else if (type == TextFieldType.nameInputMultiLanguage) {
    arrInputFormatter.add(LengthLimitingTextInputFormatter(maxLength));
  }
  else if (type == TextFieldType.nameWithSpace) {
    arrInputFormatter.add(LengthLimitingTextInputFormatter(maxLength));
    arrInputFormatter.add(FilteringTextInputFormatter.allow(RegExp(CharacterSetType.nameWithSpaceRegex)));
    arrInputFormatter.add(FilteringTextInputFormatter.deny("  ", replacementString: " "));
  }
  else if (type == TextFieldType.numericOnly || type == TextFieldType.phoneNumber) {
    arrInputFormatter.add(LengthLimitingTextInputFormatter(maxLength));
    arrInputFormatter.add(FilteringTextInputFormatter.allow(RegExp(CharacterSetType.numberOnlyRegex)));
  }
  else if (type == TextFieldType.charactersWithNumbers) {
    arrInputFormatter.add(LengthLimitingTextInputFormatter(maxLength));
    arrInputFormatter.add(FilteringTextInputFormatter.allow(RegExp(CharacterSetType.charactersWithNumbersRegex)));
  }
  else if (type == TextFieldType.charactersNumbersWithSpace) {
    arrInputFormatter.add(LengthLimitingTextInputFormatter(maxLength));
    arrInputFormatter.add(FilteringTextInputFormatter.allow(RegExp(CharacterSetType.charactersNumbersWithSpaceRegex)));
    arrInputFormatter.add(FilteringTextInputFormatter.deny("  ", replacementString: " "));
  }
  else if (type == TextFieldType.charactersWithSpecialCharacter) {
    arrInputFormatter.add(LengthLimitingTextInputFormatter(maxLength));
    arrInputFormatter.add(FilteringTextInputFormatter.allow(RegExp(CharacterSetType.charactersWithSpecialCharacterRegex)));
  }
  else if (type == TextFieldType.charactersSpecialCharacterWithSpace) {
    arrInputFormatter.add(LengthLimitingTextInputFormatter(maxLength));
    arrInputFormatter.add(FilteringTextInputFormatter.allow(RegExp(CharacterSetType.charactersSpecialCharacterWithSpaceRegex)));
    arrInputFormatter.add(FilteringTextInputFormatter.deny("  ", replacementString: " "));
  }
  else if (type == TextFieldType.none && maxLength != null) {
    arrInputFormatter.add(LengthLimitingTextInputFormatter(maxLength));
    //arrInputFormatter.add(LengthLimitFormatter(maxLength));
  }
  else if (type == TextFieldType.cardExpiry) {
    arrInputFormatter.add(LengthLimitingTextInputFormatter(maxLength));
    arrInputFormatter.add(CardExpiryTextInputFormatter());
    //arrInputFormatter.add(WhitelistingTextInputFormatter(new RegExp(CharacterSetType.cardExpiryRegex)));
  }
  else if (type == TextFieldType.card) {
    //arrInputFormatter.add(WhitelistingTextInputFormatter.digitsOnly);
    arrInputFormatter.add(LengthLimitingTextInputFormatter(maxLength));
    arrInputFormatter.add(CardNumberInputFormatter());
  }
  return arrInputFormatter;
}


TextInputType getKeyBoardType(TextFieldType type) {

  TextInputType keyBoardType = TextInputType.text;
  if (type == TextFieldType.email) {
    keyBoardType = TextInputType.emailAddress;
  } else if (type == TextFieldType.numericOnly || type == TextFieldType.phoneNumber || type == TextFieldType.cardExpiry) {
    keyBoardType = TextInputType.number;
  }
  return keyBoardType;

}

int getMinLength(TextFieldType type) {
  var minLength = 0;
  if (type == TextFieldType.email) {
    minLength = 2;
  } else if ((type == TextFieldType.password) || (type == TextFieldType.passwordVisible)) {
    minLength = 6;
  } else if (type == TextFieldType.nameInputMultiLanguage) {
    minLength = 2;
  } else if (type == TextFieldType.nameWithSpace) {
    minLength = 2;
  }
  return minLength;
}

int getMaxLength(TextFieldType type) {
  var maxLength = 2000;
  if (type == TextFieldType.email) {
    maxLength = 50;
  } else if ((type == TextFieldType.password) || (type == TextFieldType.passwordVisible)) {
    maxLength = 16;
  } else if (type == TextFieldType.nameInputMultiLanguage) {
    maxLength = 50;
  } else if (type == TextFieldType.phoneNumber) {
    maxLength = 10;
  }
  return maxLength;
}

class RegexValidator implements StringValidator {

  final String? regexSource;
  final String? allowInputsequence;

  RegexValidator({this.regexSource, this.allowInputsequence});
  @override
  bool isValid(String value) {
    try {
      final regex = RegExp(regexSource!);
      final matches = regex.allMatches(value);
      for (Match match in matches) {
        if (match.start == 0 && match.end == value.length) {
          return true;
        }
      }
      return false;
    } catch (e) {
      assert(false, e.toString());
      return true;
    }
  }
}

abstract class StringValidator {
  bool isValid(String value);
}

//region Card Expiry Formatter
class LengthLimitFormatter extends TextInputFormatter {

  int maxLength = 200;
  LengthLimitFormatter(this.maxLength);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    String updatedStr = newValue.text;
    if (updatedStr.length > maxLength) {
      updatedStr = updatedStr.substring(0, maxLength);
    }
    return TextEditingValue(
      text: updatedStr,
      selection: TextSelection.collapsed(offset: updatedStr.length),
    );
  }
}
//endregion


//region Card Expiry Formatter
class CardExpiryTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    String updatedStr = newValue.text.replaceAll("/", "");

    int usedSubstringIndex = 0;

    final int newTextLength = updatedStr.length;

    final StringBuffer newText = StringBuffer();
    if (newTextLength > 2) {
      newText.write(updatedStr.substring(0, usedSubstringIndex = 2) + '/');
    }
    newText.write(updatedStr.substring(usedSubstringIndex));

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
//endregion


class ValidatorWhitelistingInputFormatter implements TextInputFormatter {
  final StringValidator? editingValidator;
  final TextFieldType? textType;
  final int? maxLength;

  ValidatorWhitelistingInputFormatter({this.editingValidator, this.textType, this.maxLength});

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    if (newValue.text.startsWith(" ")) {
      return oldValue;
    }

    //debugPrint("New Text :: ${newValue.text} oldText :: ${oldValue.text} maxLenght :: $maxLength");
    if (newValue.text.length > maxLength!) {
      return oldValue;
    }

    // if no validation then allow alll input
    if (textType == TextFieldType.none) return newValue;

    // Back space always allow
    if ((oldValue.text.length - newValue.text.length) > 0) {
      return newValue;
    }

    if (newValue.text.contains("  ")) {
      return oldValue;
    }

    // code For not allow consecutive space using regex not possible
    if ((textType != TextFieldType.none) && (newValue.text.isNotEmpty) && (oldValue.text.isNotEmpty)) {
      if ((newValue.text[newValue.text.length - 1] == " ") && (oldValue.text[oldValue.text.length - 1] == " ")) {
        return oldValue;
      }
      else if ((oldValue.text.length == newValue.text.length) && (oldValue.text[oldValue.text.length - 1] == " " && newValue.text[oldValue.text.length - 1] == ".")) {
        return oldValue;
      }
    }

    // Only for textfield type price
    if (textType == TextFieldType.price) {
      if ((newValue.text.length > oldValue.text.length) && !(newValue.text.contains('.')) && (newValue.text.length > (maxLength!-3))) {
        return TextEditingValue(
            text: '${oldValue.text}.${newValue.text.substring(newValue.text.length-1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            )
        );
      }
    }

    // Means user enter input one by one
    if (((newValue.text.length - oldValue.text.length) == 1)) {
      var updatedString = newValue.text.replaceFirst(oldValue.text, "", 0);
      if (newValue.text.length > 4 && !(textType == TextFieldType.email || textType == TextFieldType.password)) {
        updatedString = newValue.text.substring(newValue.text.length - 4, newValue.text.length);
      }
      final newValueValid = editingValidator!.isValid(updatedString);
      if (newValueValid) {
        return newValue;
      }
      return oldValue;
    }

    //debugPrint("Validation check start");
    final newValueValid = editingValidator!.isValid(newValue.text);
    final oldValueValid = editingValidator!.isValid(oldValue.text);
    //debugPrint("oldValueValid :$oldValueValid  newValueValid :$newValueValid");


    if (!oldValueValid && !newValueValid) { return oldValue; }

    if (oldValueValid && !newValueValid) {
      if (newValue.text.isEmpty) return newValue;
      return oldValue;
    }
    return newValue;
  }
}

//region PhoneNumber Formatter
class PhoneNumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {


    String updatedStr = newValue.text.replaceAll("(", "");
    updatedStr = updatedStr.replaceAll(")", "");
    updatedStr = updatedStr.replaceAll("-", "");
    updatedStr = updatedStr.replaceAll(" ", "");


    int usedSubstringIndex = 0;

    final int newTextLength = updatedStr.length;

    final StringBuffer newText = StringBuffer();
    if (newTextLength >= 4) {
      newText.write(updatedStr.substring(0, usedSubstringIndex = 3) + '-');
    }
    if (newTextLength >= 7) {
      newText.write(updatedStr.substring(3, usedSubstringIndex = 6) + '-');
    }
    if (newTextLength >= 11) {
      newText.write(updatedStr.substring(6, usedSubstringIndex = 10) + '-');
    }
    if (newTextLength >= usedSubstringIndex) { // Dump the rest.
      newText.write(updatedStr.substring(usedSubstringIndex));
    }


    int selectionIndex = newValue.selection.start + (newValue.text.length - newText.length).abs();
    selectionIndex = min(selectionIndex, newText.length);

    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
//endregion

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    if (text.startsWith(RegExp(r'((34)|(37))'))) {
      for (int i = 0; i < text.length; i++) {
        buffer.write(text[i]);
        var nonZeroIndex = i + 1;
        if (nonZeroIndex == 4 && nonZeroIndex != text.length) {
          buffer.write(' '); // Add spaces.
        } else if (nonZeroIndex == 10 && nonZeroIndex != text.length) {
          buffer.write(' '); // Add spaces.
        }
      }
    } else {
      for (int i = 0; i < text.length; i++) {
        buffer.write(text[i]);
        var nonZeroIndex = i + 1;
        if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
          buffer.write(' '); // Add spaces.
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}