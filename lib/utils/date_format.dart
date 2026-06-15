import 'package:intl/intl.dart';
class DateAndTimeFormat {

  ///Format String
 static const String yyyyMMddTHHmmSS = "yyyy-MM-ddTHH:mm:ss";
 static const String yyyyMMdd = "yyyy-MM-dd";


  ///Date Format
  String nowDateTime =  "${DateTime.now()}";
  String monthDayYear = DateFormat.yMd().format(DateTime.now()); // 9/22/2023
  String yearMonthDay = DateFormat(yyyyMMdd).format(DateTime.now()); // 2023-09-22
  String dayMonthYear = DateFormat("dd MMM yyyy").format(DateTime.now()); // 2023-09-22
  String formalDateFormat = DateFormat('EEEE, MMMM d, y').format(DateTime.now()); // Thursday, September 22, 2023

  /// Time Formats
  String twentyFourHour = DateFormat.Hm().format(DateTime.now()); // 14:26
  String twelveHour  = DateFormat.jm().format(DateTime.now()); // 2:26 PM

 /// Date & Time Format
  String dateAndTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()); // 2023-09-22 14:26:34
 String formattedDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(DateTime.now());


}
