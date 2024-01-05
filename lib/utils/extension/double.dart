import 'dart:math';

extension DoubleExtensions on double {
  double roundToDecimalPlaces(int decimalPlaces) {
    num multiplier = pow(10.0, decimalPlaces);
    return (this * multiplier).round() / multiplier;
  }
}
