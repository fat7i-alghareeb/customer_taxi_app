/// Formats a money amount with a currency symbol/code, e.g. "€ 12.50".
String formatMoney(double value, String currencyCode) {
  final symbol = _symbolFor(currencyCode);
  final amount = value.toStringAsFixed(2);
  return symbol.isEmpty ? '$amount $currencyCode' : '$symbol $amount';
}

String _symbolFor(String currencyCode) {
  switch (currencyCode.toUpperCase()) {
    case 'EUR':
      return '€';
    case 'USD':
      return '\$';
    case 'GBP':
      return '£';
    default:
      return '';
  }
}
