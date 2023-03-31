class StringFunctions {
  StringFunctions._();

  static double strToFloat(String value) {
    String result = value.replaceAll('R\$', '');
    result = result.replaceAll('.', '');
    result = result.replaceAll(',', '.');
    return double.tryParse(result) ?? 0;
  }

  static String floatToStr(double? value) {
    String result = value.toString();
    result = result.replaceAll('.', ',');
    return result;
  }
}
