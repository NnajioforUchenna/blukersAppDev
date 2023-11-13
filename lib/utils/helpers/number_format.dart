import 'package:intl/intl.dart';

class NumberFormatHelper {
  strToStrSimpleCurrency(value) {
    value = double.parse(value);
    var formatted = NumberFormat.simpleCurrency().format(value);
    return formatted;
  }

  String doubleToStrSimpleCurrency(double? value) {
    NumberFormat customFormat = NumberFormat("#,##0.##", "en_US");
    return '\$${customFormat.format(value)}';
  }
}
