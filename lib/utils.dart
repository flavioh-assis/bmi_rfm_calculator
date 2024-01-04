double textToDouble(String text) {
  if (text.isEmpty) {
    return 0.0;
  }

  return double.parse(text.replaceFirst(',', '.'));
}

String doubleToText(double number, {int? decimalPlaces}) {
  return number.toStringAsFixed(decimalPlaces ?? 1).replaceFirst('.', ',');
}
