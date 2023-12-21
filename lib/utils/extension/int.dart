extension IntExtension on int {
  String get commaString {
    String strNumber = toString();
    RegExp regExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String result =
        strNumber.replaceAllMapped(regExp, (Match match) => '${match[1]},');
    return result;
  }
}
