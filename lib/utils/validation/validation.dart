import 'package:tuple/tuple.dart';
import '../../localization/localization.dart';
import '../app_constant.dart';
import '../navigation/navigation_service.dart';

enum ValidationType {
  firstName,
  lastName,
  username,
  email,
  phone,
  dateOfBirth,
  password,
  confirmPassword,
  oldPassword,
  newPassword,
  none,
}

class Validation {
  static const int _zero = 0;
  static const int _two = 2;
  static const int _six = 8;
  static const int _ten = 10;


  Tuple2<bool, String> validateFirstName(String value) {
    String errorMessage = '';
    if (value.length == Validation._zero) {
      errorMessage =
          Translations.of(NavigationService().context).msgEmptyFirstName;
    } else if (value.length < Validation._two) {
      errorMessage =
          Translations.of(NavigationService().context).msgValidFirstName;
    }

    return Tuple2(errorMessage.isEmpty, errorMessage);
  }

  Tuple2<bool, String> validateLastName(String value) {
    String errorMessage = '';
    if (value.length == Validation._zero) {
      errorMessage =
          Translations.of(NavigationService().context).msgEmptyLastName;
    } else if (value.length < Validation._two) {
      errorMessage =
          Translations.of(NavigationService().context).msgValidLastName;
    }

    return Tuple2(errorMessage.isEmpty, errorMessage);
  }

  Tuple2<bool, String> validateDateOfBirth(String value) {
    String errorMessage = '';
    if (value.length == Validation._zero) {
      errorMessage =
          Translations.of(NavigationService().context).strEnterDateOfBirth;
    }
    return Tuple2(errorMessage.isEmpty, errorMessage);
  }

  Tuple2<bool, String> validatePhoneNumber(String value) {
    String errorMessage = '';
    if (value.length == Validation._zero) {
      errorMessage =
          Translations.of(NavigationService().context).strEmptyPhone;
    } else if (value.length != Validation._ten) {
      errorMessage =
          Translations.of(NavigationService().context).strValidPhone;
    }
    return Tuple2(errorMessage.isEmpty, errorMessage);
  }

  Tuple2<bool, String> validateEmail(String value) {
    RegExp regExp1 = emailRegex;
    String errorMessage = '';

    if (value.length == Validation._zero) {
      errorMessage =
          Translations.of(NavigationService().context).msgEmptyEmail;
    } else if (!regExp1.hasMatch(value)) {
      errorMessage = Translations.of(NavigationService().context).msgValidEmail;
    }

    return Tuple2(errorMessage.isEmpty, errorMessage);
  }

  Tuple2<bool, String> validateUserName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = RegExp(pattern);
    String _errorMessage = '';

    if (value.length == Validation._zero) {
      _errorMessage = Translations.of(NavigationService().context).strFirstName;
    } else if (value.length < Validation._two || !regExp.hasMatch(value)) {
      _errorMessage = Translations.of(NavigationService().context).strValidUserName;
    }
    return Tuple2(_errorMessage.isEmpty, _errorMessage);
  }

  Tuple2<bool, String> validatePassword(String value) {
    String errorMessage = '';
    if (value.length == Validation._zero) {
      errorMessage =
          Translations.of(NavigationService().context).msgEmptyPassword;
    } else if (value.length < Validation._six) {
      errorMessage =
          Translations.of(NavigationService().context).msgValidPassword;
    }
    return Tuple2(errorMessage.isEmpty, errorMessage);
  }

  Tuple2<bool, String> validateConfirmPassword(String value) {
    String errorMessage = '';
    if (value.length == Validation._zero) {
      errorMessage = Translations.of(NavigationService().context).msgEmptyReEnterPassword;
    }
    return Tuple2(errorMessage.isEmpty, errorMessage);
  }

  Tuple2<bool, String> validateOldPassword(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyOldPassword;
    } else if (value.length < Validation._six) {
      _errorMessage =
          Translations.of(NavigationService().context).msgValidOldPassword;
    }
    return Tuple2(_errorMessage.isEmpty, _errorMessage);
  }

  Tuple2<bool, String> validateNewPassword(String value) {
    String _errorMessage = '';
    if (value.length == Validation._zero) {
      _errorMessage =
          Translations.of(NavigationService().context).msgEmptyNewPassword;
    } else if (value.length < Validation._six) {
      _errorMessage =
          Translations.of(NavigationService().context).msgValidNewPassword;
    }
    return Tuple2(_errorMessage.isEmpty, _errorMessage);
  }

  Tuple3<bool, String, ValidationType> checkValidationForTextFieldWithType( List<Tuple2<ValidationType, String>> list) {
    Tuple3<bool, String, ValidationType> isValid = const Tuple3(true, '', ValidationType.none);

    for (Tuple2<ValidationType, String> textOption in list) {
      Tuple2<bool, String> res = const Tuple2(true, '');
      if (textOption.item1 == ValidationType.firstName) {
        res = validateFirstName(textOption.item2);
      } else if (textOption.item1 == ValidationType.lastName) {
        res = validateLastName(textOption.item2);
      } else if (textOption.item1 == ValidationType.username) {
        res = validateUserName(textOption.item2);
      } else if (textOption.item1 == ValidationType.email) {
        res = validateEmail(textOption.item2);
      }else if (textOption.item1 == ValidationType.phone) {
        res = validatePhoneNumber(textOption.item2);
      } else if (textOption.item1 == ValidationType.password) {
        res = validatePassword(textOption.item2);
      } else if (textOption.item1 == ValidationType.confirmPassword) {
        res = validateConfirmPassword(textOption.item2);
      } else if (textOption.item1 == ValidationType.oldPassword) {
        res = validateOldPassword(textOption.item2);
      } else if (textOption.item1 == ValidationType.newPassword) {
        res = validateNewPassword(textOption.item2);
      } else if (textOption.item1 == ValidationType.confirmPassword) {
        res = validateConfirmPassword(textOption.item2);
      } else if (textOption.item1 == ValidationType.dateOfBirth) {
        res = validateDateOfBirth(textOption.item2);
      }
      isValid = Tuple3(res.item1, res.item2, textOption.item1);
      if (!isValid.item1) {
        break;
      }
    }
    return isValid;
  }

  // VALIDATE EMPTY FIELDS ----------------------------------------------------------------------------------------------------------------------------------------------
  Tuple2<bool, String> validEmptyFields(String value, String fields) {
    String errorMessage = '';

    if (value.length == Validation._zero) {
      errorMessage = fields;
    } else {
      errorMessage = '';
    }
    return Tuple2(errorMessage.isEmpty, errorMessage);
  }
}

