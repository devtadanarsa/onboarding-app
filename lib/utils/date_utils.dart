import 'package:intl/intl.dart';

String formatDate(String date) {
  DateTime dateTime = DateTime.parse(date);
  DateFormat outputFormat = DateFormat('MMM dd, yyyy');
  return outputFormat.format(dateTime);
}

String formatDateTime(String dateTime) {
  DateTime parsedDateTime = DateTime.parse(dateTime);
  DateFormat outputFormat = DateFormat('MMM dd, yyyy - HH:mm');
  return outputFormat.format(parsedDateTime);
}
