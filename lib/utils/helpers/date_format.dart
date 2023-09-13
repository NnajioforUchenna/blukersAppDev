import 'package:intl/intl.dart';

class DateFormatHelper {
  intToStrDDMMYY(timestamp) {
    // int timestamp = 1638592424384;
    DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String fdatetime = DateFormat('dd-MMM-yyy')
        .format(tsdate); // DateFormat() is from intl package
    // print(fdatetime); // output: 04-Dec-2021
    return fdatetime;
  }
}
