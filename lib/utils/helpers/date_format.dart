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

  //

  int getCurrentDateTimeAsInt() {
    DateTime now = DateTime.now();
    int dateTimeAsInt = now.millisecondsSinceEpoch;
    return dateTimeAsInt;
  }

  DateTime convertIntToDateTime(int dateTimeAsInt) {
    return DateTime.fromMillisecondsSinceEpoch(dateTimeAsInt);
  }

  //

  Map<String, dynamic> getDate(DateTime dateTime) {
    String year4Digits = dateTime.year.toString().padLeft(2, '0');
    String year2Digits = dateTime.year.toString().padLeft(2, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    return {
      'year': dateTime.year,
      'month': dateTime.month,
      'day': dateTime.day,
      'yyyymmdd': '$year4Digits-$month-$day',
      'yymmdd': '$year2Digits-$month-$day',
      'mmddyyyy': '$month-$day-$year4Digits',
      'mmddyy': '$month-$day-$year2Digits',
      'ddmmyyyy': '$day-$month-$year4Digits',
      'ddmmyy': '$day-$month-$year2Digits',
    };
  }

  Map<String, dynamic> getTime(DateTime dateTime) {
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    String second = dateTime.second.toString().padLeft(2, '0');
    return {
      'hour': dateTime.hour,
      'minute': dateTime.minute,
      'second': dateTime.second,
      'millisecond': dateTime.millisecond,
      'hhmmss': '$hour:$minute:$second',
      'hhmm': '$hour:$minute',
    };
  }

  int getYear(DateTime dateTime) {
    return dateTime.year;
  }

  int getMonth(DateTime dateTime) {
    return dateTime.month;
  }

  int getDay(DateTime dateTime) {
    return dateTime.day;
  }

  String getHourAndMinutes(DateTime dateTime) {
    String hour = dateTime.hour.toString().padLeft(2, '0');
    String minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
    //   return {
    //     'hour': dateTime.hour,
    //     'minute': dateTime.minute,
    //   };
  }

  int getHour(DateTime dateTime) {
    return dateTime.hour;
  }

  int getMinutes(DateTime dateTime) {
    return dateTime.minute;
  }
}

/*
// EXAMPLES:
// Get the current date and time as an integer
int currentDateTimeInt = DateFormatHelper().getCurrentDateTimeAsInt();
print("Current date and time as integer: $currentDateTimeInt");
// Output:
// Current date and time as integer: 1695316889213
// Convert the integer back to a DateTime object
DateTime convertedDateTime = DateFormatHelper().convertIntToDateTime(currentDateTimeInt);
print("Converted date and time: $convertedDateTime");
// Output:
// Converted date and time: 2023-09-21 12:21:29.213
//
Map<String, dynamic> getDateResults = DateFormatHelper().getDate(convertedDateTime);
print("date: $getDateResults");
// Output:
// date: {year: 2023, month: 9, day: 21} 
Map<String, dynamic> getTimeResults = DateFormatHelper().getTime(convertedDateTime);
print("time: $getTimeResults");
// Output:
// time: {hour: 12, minute: 17, second: 39, millisecond: 418}
int getYearResults = DateFormatHelper().getYear(convertedDateTime);
print("year: $getYearResults"); 
// Output:
// year: 2023
int getMonthResults = DateFormatHelper().getMonth(convertedDateTime);
print("month: $getMonthResults"); 
// Output:
// month: 9
int getDayResults = DateFormatHelper().getDay(convertedDateTime);
print("day: $getDayResults"); 
// Output:
// day: 21
String getHourAndMinutesResults = DateFormatHelper().getHourAndMinutes(convertedDateTime);
print("hourAndMinutes: $getHourAndMinutesResults"); 
// Output:
// hourAndMinutes: {hour: 12, minute: 19}
int getHourResults = DateFormatHelper().getHour(convertedDateTime);
print("hour: $getHourResults"); 
// Output:
// hour: 12
int getMinutesResults = DateFormatHelper().getMinutes(convertedDateTime);
print("minutes: $getMinutesResults"); 
// Output:
// minutes: 20
*/