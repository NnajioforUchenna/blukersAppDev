import 'package:intl/intl.dart';

class NumberFormatHelper {
  strToStrSimpleCurrency(value) {
    value = double.parse(value);
    var formatted = NumberFormat.simpleCurrency().format(value);
    return formatted;
  }

  doubleToStrSimpleCurrency(value) {
    var formatted = NumberFormat.simpleCurrency().format(value);
    return formatted.toString();
  }
}
