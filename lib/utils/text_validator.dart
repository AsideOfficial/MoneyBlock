class TextValidator {
  static bool isNameFormat(String input) {
    RegExp regex = RegExp(r'^[가-힣]{2,}( [가-힣]{2,})?$');
    return regex.hasMatch(input);
  }

  static bool isPhoneNumberFormat(String input) {
    RegExp regex = RegExp(r'^01[016789]\d{3,4}\d{4}$');
    return regex.hasMatch(input);
  }

  static bool isDateFormat(String input) {
    RegExp regex = RegExp(r'^\d{4}\.\d{2}\.\d{2}$');
    return regex.hasMatch(input);
  }

  static bool isGenderFormat(String input) {
    return (input == '남' || input == '여');
  }

  static bool isLocationFormat(String input) {
    RegExp regex = RegExp(r'^[가-힣]+시 [가-힣]+구$');
    return regex.hasMatch(input);
  }
}
